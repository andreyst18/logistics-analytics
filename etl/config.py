from datetime import date

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # PostgreSQL
    postgres_host: str = Field(default="localhost", alias="POSTGRES_HOST")
    postgres_port: int = Field(default=5432, alias="POSTGRES_PORT")
    postgres_db: str = Field(default="deals_bigdata", alias="POSTGRES_DB")
    postgres_user: str = Field(default="postgres", alias="POSTGRES_USER")
    postgres_password: str = Field(default="postgres", alias="POSTGRES_PASSWORD")

    # ETL
    etl_start_date: date = Field(default=date(2023, 10, 1), alias="ETL_START_DATE")
    etl_end_date: date = Field(default=date(2026, 10, 26), alias="ETL_END_DATE")
    as_of: date = Field(default=date(2026, 10, 26), alias="AS_OF")
    batch_size: int = Field(default=10_000, alias="ETL_BATCH_SIZE")

    @property
    def dsn(self) -> str:
        return (
            f"postgresql+psycopg2://{self.postgres_user}:{self.postgres_password}"
            f"@{self.postgres_host}:{self.postgres_port}/{self.postgres_db}"
        )


settings = Settings()