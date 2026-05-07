"""
============================================================
Project: Data Analytics with SQL, MongoDB & BigQuery
File: config/settings.py
Description: Centralized configuration using environment
             variables — no hardcoded secrets
============================================================
"""

import os
from dotenv import load_dotenv

load_dotenv()


class Settings:
    # ── MySQL ──────────────────────────────────────────────
    MYSQL_HOST:     str = os.getenv("MYSQL_HOST",     "localhost")
    MYSQL_PORT:     int = int(os.getenv("MYSQL_PORT", "3306"))
    MYSQL_USER:     str = os.getenv("MYSQL_USER",     "root")
    MYSQL_PASSWORD: str = os.getenv("MYSQL_PASSWORD", "")
    MYSQL_DATABASE: str = os.getenv("MYSQL_DATABASE", "analytics_db")

    # ── MongoDB ────────────────────────────────────────────
    MONGODB_URI:      str = os.getenv("MONGODB_URI",      "mongodb://localhost:27017")
    MONGODB_DATABASE: str = os.getenv("MONGODB_DATABASE", "analytics_db")

    # ── Google BigQuery ────────────────────────────────────
    BIGQUERY_PROJECT_ID:      str = os.getenv("BIGQUERY_PROJECT_ID",      "your-gcp-project-id")
    BIGQUERY_DATASET_ID:      str = os.getenv("BIGQUERY_DATASET_ID",      "analytics_dataset")
    BIGQUERY_LOCATION:        str = os.getenv("BIGQUERY_LOCATION",        "US")
    GOOGLE_APPLICATION_CREDENTIALS: str = os.getenv(
        "GOOGLE_APPLICATION_CREDENTIALS",
        "credentials/bigquery_service_account.json"
    )

    # ── Export paths ───────────────────────────────────────
    EXPORT_DIR: str = os.getenv("EXPORT_DIR", "exports")

    @property
    def mysql_url(self) -> str:
        return (
            f"mysql+mysqlconnector://{self.MYSQL_USER}:{self.MYSQL_PASSWORD}"
            f"@{self.MYSQL_HOST}:{self.MYSQL_PORT}/{self.MYSQL_DATABASE}"
        )

    def validate(self) -> None:
        """Raise ValueError if any critical setting is missing or default."""
        errors = []
        if self.BIGQUERY_PROJECT_ID == "your-gcp-project-id":
            errors.append("BIGQUERY_PROJECT_ID is not set in .env")
        if not self.MYSQL_PASSWORD and self.MYSQL_HOST != "localhost":
            errors.append("MYSQL_PASSWORD is empty for a non-local host")
        if errors:
            raise ValueError("Configuration errors:\n" + "\n".join(f"  - {e}" for e in errors))
