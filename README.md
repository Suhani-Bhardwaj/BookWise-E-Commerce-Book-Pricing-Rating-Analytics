# 📚 BookWise — E-Commerce Book Pricing & Rating Analytics

BookWise is an end-to-end e-commerce data analytics and machine learning project that analyzes an online bookstore catalog to understand book pricing, ratings, categories, inventory availability, and product characteristics.

The project follows a complete analytics workflow starting from web data collection and continuing through data cleaning, feature engineering, SQL analysis, exploratory data analysis, machine learning-based product segmentation, and interactive Power BI visualization.

---

## 📌 Project Overview

The objective of BookWise is to transform raw web-scraped bookstore data into meaningful business insights.

The project focuses on questions such as:

- How are book prices distributed?
- How are ratings distributed?
- Which categories contain the most books?
- What proportion of books are low, medium, or high stock?
- How do price and ratings vary across categories?
- Which books are among the most expensive?
- Are there natural groups of books with similar characteristics?
- Which book segments require different types of business attention?

---

## 🔄 Project Workflow

```text
Books to Scrape
       ↓
Web Scraping
       ↓
Raw Dataset
       ↓
Data Cleaning & Preprocessing
       ↓
Feature Engineering
       ↓
      ┌───────────────┬────────────────┐
      ↓               ↓                ↓
   SQL Analysis       EDA         Machine Learning
      ↓               ↓                ↓
      └───────────────┴────────────────┘
                       ↓
                Business Insights
                       ↓
                  Power BI


🌐 Data Source

The data was collected from Books to Scrape, a publicly accessible website designed for web-scraping practice.

Source:

https://books.toscrape.com/

The dataset represents a snapshot of the book catalog available on the website at the time of data collection. It is not historical sales data.

1. Web Data Acquisition

Python was used to collect book information programmatically.

Tools Used
Python
Requests
BeautifulSoup
Pandas
Data Collection Process

The scraping process was performed in two stages:

Book-level information was collected from the catalog/listing pages.
Individual product pages were visited to enrich each book record with additional information.

The catalog contained 50 pages with approximately 20 books per page, resulting in a final dataset of 1,000 book records.

Information Collected

The scraped data includes:

Book Title
Price
Rating
Availability
Product URL
Category
Description
UPC
Product Type
Tax
Number Available
Number of Reviews
Stock Quantity
2. Data Cleaning & Preprocessing

The raw scraped data was cleaned and transformed into an analysis-ready dataset using Pandas and NumPy.

Main preprocessing steps
Checked for missing values
Checked for duplicate records
Corrected text encoding issues
Converted price and tax values into numerical formats
Converted ratings from text into numerical values
Extracted stock quantity from availability information
Standardized text fields
Handled missing product descriptions
Validated categorical variables
Retained source-provided unclassified categories without making unsupported assumptions

The final cleaned dataset contains:

1,000 records and 19 features

with no duplicate records and no missing values after preprocessing.

3. Feature Engineering

Additional analytical features were created from the cleaned data.

Rating Category

Ratings were grouped into:

Low
Average
High
Price Band

Books were grouped into:

Budget
Mid-Range
Premium
Stock Status

Inventory was classified into:

Low Stock
Medium Stock
High Stock
Text-Based Features

The following features were created:

Title Length
Description Length
Description Word Count

These features were later used for exploratory analysis and machine-learning segmentation.

4. SQL Data Analysis

The cleaned dataset was imported into MySQL for structured business analysis.

SQL Concepts Used
SELECT
WHERE
ORDER BY
LIMIT
COUNT
SUM
AVG
MIN
MAX
GROUP BY
HAVING
CASE statements
Subqueries
Common Table Expressions (CTEs)
Window Functions
RANK()
ROW_NUMBER()
DENSE_RANK()
AVG() OVER()
Joins
Analysis Areas

The SQL analysis focused on:

Book pricing
Ratings
Categories
Inventory levels
Price bands
Stock status
Category-level comparisons
High-value and low-stock books
Ranking and comparative analysis

The SQL queries are available in:

sql/SQL_data_analysis.sql

5. Exploratory Data Analysis

Exploratory Data Analysis was performed using Python visualization libraries.

Libraries Used
Matplotlib
Seaborn
Pandas

A total of 19 visualizations were created to investigate:

Price distribution
Rating distribution
Price bands
Rating categories
Stock status
Category distribution
Price vs. rating
Average price by category
Average rating by category
Average stock by category
Average stock by price band
Average stock by rating
Average price by rating category
Average price by stock status
Stock quantity distribution
Price distribution by price band
Stock quantity by rating category
Top 10 most expensive books
Outliers
6. Machine Learning — Book Segmentation

The machine-learning component uses K-Means clustering, an unsupervised machine-learning algorithm.

Why Clustering?

The dataset does not contain a reliable supervised target variable for a meaningful prediction problem.

Therefore, instead of predicting an outcome, K-Means was used to identify natural groups of books with similar characteristics.

Features Used

Six numerical features were selected:

Price
Rating
Stock Quantity
Title Length
Description Length
Description Word Count

Derived categorical variables such as Price Band, Rating Category, and Stock Status were excluded from clustering because they are derived from the original numerical variables.

📏 Feature Scaling

The selected features have different numerical ranges.

For example, rating ranges from 1–5, while description length can contain thousands of characters.

Therefore, StandardScaler was used before applying K-Means so that features with larger numerical scales would not dominate the distance calculations.

🔢 Selecting the Number of Clusters

Different values of K from 2 to 10 were evaluated using:

Elbow Method
Silhouette Score
Davies-Bouldin Index
Calinski-Harabasz Score

The highest numerical Silhouette Score occurred at K=2. However, K=3 was selected for the final segmentation because it provided a more useful level of business differentiation while maintaining a reasonable clustering structure.

🎯 Final Book Segments

The final K-Means model produced three segments:

Cluster 0 — High-Stock Books

Books with relatively higher inventory levels and comparatively shorter content descriptions.

Cluster 1 — Low-Stock Books

Books with relatively lower inventory levels and comparatively shorter content descriptions.

Cluster 2 — Detailed-Content Books

Books characterized by substantially longer titles and descriptions, with moderate inventory levels.

The clusters have relatively similar average prices and ratings, indicating that inventory and content characteristics contribute more strongly to the segmentation than price and rating.

🔬 PCA Visualization

Principal Component Analysis (PCA) was used to reduce the six-dimensional feature space to two principal components for visualization.

This makes it easier to visually inspect the distribution of the resulting clusters in a two-dimensional plot.

PCA was used primarily for visualization; the K-Means model was trained using the standardized six-feature dataset.

💡 Key Insights

Some important findings from the analysis include:

The final cleaned dataset contains 1,000 books and 19 features.
The average book price is approximately 35.07.
The average rating is approximately 2.92 out of 5.
The average stock quantity is approximately 8.59.
A large proportion of the catalog falls into the Low Stock category.
Mid-Range and Premium books represent a large portion of the catalog.
The clustering analysis indicates that inventory and content characteristics contribute more strongly to the segmentation than price and rating.
The Low-Stock segment can be useful for identifying books that require closer inventory monitoring.
The Detailed-Content segment highlights products with substantially longer titles and descriptions.

These findings describe the scraped catalog and should not be interpreted as sales or demand measurements because the dataset does not contain actual sales information.

📈 Power BI Dashboard

Microsoft Power BI was used as the business intelligence and visualization layer of the project.

The dashboard presents insights related to:

Book pricing
Ratings
Categories
Inventory
Price bands
Stock status
Book segments

The Power BI file is available in:

dashboard/dashboard.pbix

🛠️ Technologies Used
Area	Tools
Programming	Python
Web Scraping	Requests, BeautifulSoup
Data Processing	Pandas, NumPy
Visualization	Matplotlib, Seaborn
Database	MySQL
SQL Analysis	MySQL Workbench
Machine Learning	Scikit-learn
Clustering	K-Means
Scaling	StandardScaler
Dimensionality Reduction	PCA
Business Intelligence	Microsoft Power BI
Development Environment	Jupyter Notebook
📁 Project Structure
BookWise-E-Commerce-Book-Pricing-Rating-Analytics/
│
├── README.md
│
├── data/
│   ├── rawbook.csv
│   ├── enriched_raw_books.csv
│   ├── cleaned_books.csv
│   └── bookwise_clustered_data.csv
│
├── notebooks/
│   ├── 01_Web_Data_Acquisition.ipynb
│   ├── 02_Data_Cleaning_Preprocessing.ipynb
│   ├── 03_SQL_Data_Analysis.ipynb
│   ├── 04_EDA_Visualization.ipynb
│   └── 05_Machine_Learning.ipynb
│
├── sql/
│   └── SQL_data_analysis.sql
│
├── dashboard/
│   └── dashboard.pbix
│
└── charts/
    ├── EDA visualizations
    ├── clustering evaluation charts
    ├── PCA visualization
    └── cluster analysis charts
▶️ How to Run the Project
1. Clone the repository
git clone https://github.com/YOUR-USERNAME/BookWise-E-Commerce-Book-Pricing-Rating-Analytics.git
2. Install the required Python libraries
pip install pandas numpy requests beautifulsoup4 matplotlib seaborn scikit-learn mysql-connector-python
3. Run the notebooks in order
01_Web_Data_Acquisition.ipynb
        ↓
02_Data_Cleaning_Preprocessing.ipynb
        ↓
03_SQL_Data_Analysis.ipynb
        ↓
04_EDA_Visualization.ipynb
        ↓
05_Machine_Learning.ipynb
4. SQL Analysis

Import the cleaned dataset into MySQL and execute:

sql/SQL_data_analysis.sql

5. Power BI

Open:

dashboard/dashboard.pbix

using Microsoft Power BI Desktop.

⚠️ Project Limitations
The dataset is a catalog snapshot rather than historical sales data.
Actual sales, revenue, profit, and customer purchase data are not available.
Therefore, the project cannot directly measure demand or sales performance.
The source website is designed for web-scraping practice and does not represent the full complexity of a commercial bookstore.
The clustering results are exploratory product segments rather than proven customer or sales segments.
The dataset contains zero reviews across the 1,000 books, so review activity could not provide meaningful variation.
🚀 Future Improvements

The project could be extended by adding:

Historical price data
Historical inventory data
Actual sales data
Revenue and profit information
Customer purchase behavior
Demand forecasting
Stock-out prediction
Product recommendation systems
Price optimization
More advanced clustering algorithms
Time-series analysis
👩‍💻 Project Author

Suhani

Data Analytics | Python | SQL | Power BI | Machine Learning | AI

📌 Disclaimer

This project is created for educational and portfolio purposes using publicly accessible data from Books to Scrape.
The analysis represents the scraped catalog data and should not be interpreted as actual sales, revenue, or customer behavior data.
