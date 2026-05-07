// ============================================================
// PROJECT: Data Analytics with SQL, MongoDB & BigQuery
// FILE: mongodb/mongo_queries.js
// DESCRIPTION: MongoDB Shell queries used to insert, explore,
//              and analyze the reviews collection.
//              Run these in: mongosh analytics_db
// ============================================================

// ── 0. Connect and switch database ───────────────────────────
// mongosh
// use analytics_db

// ── 1. Import sample_reviews.json ────────────────────────────
// Run this from terminal (NOT inside mongosh):
// mongoimport --db analytics_db --collection reviews \
//             --file mongodb/sample_reviews.json \
//             --jsonArray

// ============================================================
// SECTION A: Explore the Collection
// ============================================================

// Count total reviews
db.reviews.countDocuments()

// View one sample document
db.reviews.findOne()

// List all unique categories
db.reviews.distinct("category")

// All reviews with rating = 5
db.reviews.find({ rating: 5 }).pretty()

// ============================================================
// SECTION B: Analysis Queries
// ============================================================

// ── B1. Average rating per category ─────────────────────────
db.reviews.aggregate([
    {
        $group: {
            _id: "$category",
            avg_rating: { $avg: "$rating" },
            total: { $sum: 1 }
        }
    },
    { $sort: { avg_rating: -1 } }
])

// ── B2. Average word count per category (descriptiveness) ───
db.reviews.aggregate([
    {
        $group: {
            _id: "$category",
            avg_word_count: { $avg: "$word_count" },
            max_word_count: { $max: "$word_count" },
            total_reviews: { $sum: 1 }
        }
    },
    { $sort: { avg_word_count: -1 } }
])

// ── B3. Highly descriptive reviews (> 70 words) per category
db.reviews.aggregate([
    {
        $group: {
            _id: "$category",
            total: { $sum: 1 },
            long_reviews: {
                $sum: { $cond: [{ $gt: ["$word_count", 70] }, 1, 0] }
            }
        }
    },
    {
        $addFields: {
            descriptive_pct: {
                $round: [
                    { $multiply: [{ $divide: ["$long_reviews", "$total"] }, 100] },
                    1
                ]
            }
        }
    },
    { $sort: { descriptive_pct: -1 } }
])

// ── B4. Number of reviews per user ──────────────────────────
db.reviews.aggregate([
    {
        $group: {
            _id: "$user_id",
            review_count: { $sum: 1 },
            avg_rating: { $avg: "$rating" }
        }
    },
    { $sort: { review_count: -1 } }
])

// ── B5. Average price per star rating (price vs sentiment) ──
db.reviews.aggregate([
    {
        $group: {
            _id: "$rating",
            avg_price: { $avg: "$product_price" },
            count: { $sum: 1 }
        }
    },
    { $sort: { _id: 1 } }
])

// ── B6. Most reviewed products ──────────────────────────────
db.reviews.aggregate([
    {
        $group: {
            _id: "$product_name",
            reviews: { $sum: 1 },
            avg_rating: { $avg: "$rating" },
            avg_words: { $avg: "$word_count" }
        }
    },
    { $sort: { reviews: -1 } },
    { $limit: 10 }
])

// ── B7. Verified vs Unverified purchase comparison ──────────
db.reviews.aggregate([
    {
        $group: {
            _id: "$verified_purchase",
            count: { $sum: 1 },
            avg_rating: { $avg: "$rating" },
            avg_words: { $avg: "$word_count" }
        }
    }
])

// ============================================================
// SECTION C: Create Indexes for Performance
// ============================================================

db.reviews.createIndex({ user_id: 1 })
db.reviews.createIndex({ product_id: 1 })
db.reviews.createIndex({ category: 1 })
db.reviews.createIndex({ rating: 1 })
db.reviews.createIndex({ created_at: -1 })

print("✅ Indexes created on reviews collection.")
