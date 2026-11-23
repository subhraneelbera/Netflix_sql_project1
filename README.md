# Netflix Movies and Data Shows Data Analysis in SQL
[Netflix_logo](https://github.com/subhraneelbera/Netflix_sql_project1/blob/main/netflix_image.webp))
# 🎬 Netflix Movies and TV Shows Data Analysis using SQL

![Netflix Banner](netflix_image.webp)

## 📌 Overview
This project analyzes Netflix's catalog of movies and TV shows using **PostgreSQL** to uncover content distribution patterns, rating trends, regional production insights, and genre popularity. By solving **15 real-world business problems**, this analysis demonstrates practical data querying, string manipulation, window functions, and Common Table Expressions (CTEs).

---

## 🎯 Objectives
- Analyze the split between **Movies** and **TV Shows** across the platform.
- Identify the most frequent content ratings for each media type.
- Evaluate country-wise content production and top-performing regions (including a deep dive into Indian content releases).
- Track content additions over recent years and categorize titles based on description keywords.
- Extract insights on genres, directors, longest movies, and frequent cast members.

---

## 🗂️ Dataset & Repository Structure
- **`netflix_titles.csv`** — Raw dataset containing Netflix movies and TV shows metadata.
- **`Solution.sql`** — Complete PostgreSQL script containing the schema setup and solutions to all 15 business questions.
- **`netflix_image.webp`** — Project banner image.

### Table Schema
```sql
DROP TABLE IF EXISTS Netflix;
CREATE TABLE Netflix (
    show_id      VARCHAR(10),
    type         VARCHAR(10),
    title        VARCHAR(1000),
    director     VARCHAR(300),
    casts        VARCHAR(1000),
    country      VARCHAR(300),
    date_added   VARCHAR(50),
    release_year INT,
    rating       VARCHAR(500),
    duration     VARCHAR(500),
    listed_in    VARCHAR(100),
    description  VARCHAR(500)
);
