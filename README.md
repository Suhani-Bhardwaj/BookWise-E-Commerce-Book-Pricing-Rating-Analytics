# 📚 BookWise — E-Commerce Book Pricing & Rating Analytics

## 📌 Project Overview

**BookWise** is an end-to-end e-commerce book analytics project that analyzes book pricing, ratings, availability, inventory, categories, and product content.

The project follows a complete data analytics workflow, starting from web data collection and continuing through data cleaning, feature engineering, SQL analysis, exploratory data analysis, machine learning, book segmentation, and Power BI visualization.

### 🔄 Project Workflow

**Web Scraping → Data Cleaning → Feature Engineering → SQL Analysis → Exploratory Data Analysis → Machine Learning → Book Segmentation → Business Insights → Power BI Dashboard**

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Collect book catalog data from an online bookstore.
- Clean and preprocess the scraped data.
- Analyze book prices, ratings, stock levels, and categories.
- Identify patterns and relationships between book attributes.
- Perform structured business analysis using SQL.
- Explore the dataset through statistical and visual analysis.
- Segment books using K-Means clustering.
- Understand the characteristics of different book segments.
- Create an interactive Power BI dashboard.

---

# 🌐 Data Source

The data was collected from **Books to Scrape**, a website created for practicing web scraping.

**Source:** https://books.toscrape.com/

The website contains **50 catalog pages with 20 books per page**. The project collected **1,000 book records** and then visited individual product pages to enrich the dataset with additional information.

---

# 🕷️ 1. Web Data Acquisition

The first stage of the project was collecting book information through web scraping.

### 🛠️ Libraries Used

- Python
- Requests
- BeautifulSoup
- Pandas

### 📊 Information Collected

The scraped data includes:

- Book Title
- Price
- Rating
- Availability
- Category
- Description
- Product URL
- UPC
- Product Type
- Tax
- Stock Quantity
- Number of Reviews

The initial scraped dataset was saved as:

`data/rawbook.csv`

The enriched dataset containing additional product-page information was saved as:

`data/enriched_raw_books.csv`

---

# 🧹 2. Data Cleaning & Preprocessing

The raw scraped data required preprocessing before it could be used for analysis.

### 🔍 Cleaning Steps

- Checked for missing values.
- Checked for duplicate records.
- Corrected text encoding issues.
- Converted price and tax values into numeric format.
- Converted book ratings into numeric values.
- Extracted stock quantity from availability information.
- Standardized data types.
- Cleaned text-based fields.
- Created additional analytical features.
- Validated the final dataset.

### 📊 Final Cleaned Dataset

The final cleaned dataset contains:

- **1,000 books**
- **19 features**
- **No duplicate records**
- **No missing values**

The cleaned dataset was saved as:

`data/cleaned_books.csv`

### 📌 Category Validation

During data validation, **67 records contained `"Add a comment"` as the category value**. These values were retained rather than manually assigning categories that were not provided by the source.

---

# ⚙️ 3. Feature Engineering

Additional features were created to make the dataset more useful for analysis.

### Rating Category

Books were grouped into rating categories based on their numerical ratings.

### Price Band

Books were grouped into different price ranges to make pricing patterns easier to analyze.

### Stock Status

Books were categorized based on their available stock quantity.

### Title Length

The number of characters in each book title.

### Description Length

The number of characters in each book description.

### Description Word Count

The number of words contained in each book description.

### Review Activity

A `Review_Activity` feature was initially explored. However, it was not retained because the available review information did not provide meaningful variation for analysis.

---

# 🗄️ 4. SQL Data Analysis

SQL was used to perform structured analysis on the cleaned BookWise dataset.

The project uses **MySQL**.

### 🔎 SQL Concepts Used

The SQL analysis includes:

- Filtering
- Aggregation
- `GROUP BY`
- `ORDER BY`
- Conditional logic
- `CASE` statements
- Aggregate functions
- Subqueries
- Joins
- Analytical/window functions

### 📌 Business Questions Explored

The SQL analysis examines questions such as:

- How do book prices vary across categories?
- Which categories have higher average prices?
- How do ratings vary across categories?
- How does stock quantity vary across different price bands?
- How does inventory vary across rating categories?
- Which books are among the most expensive?
- How do different book attributes vary across the catalog?

SQL files are available in:

`SQL/`

---

# 📊 5. Exploratory Data Analysis

Exploratory Data Analysis was performed using:

- Pandas
- Matplotlib
- Seaborn

The project includes visual analysis of:

- Price distribution
- Rating distribution
- Price band distribution
- Rating category distribution
- Stock status distribution
- Category distribution
- Price vs Rating
- Average price by category
- Average rating by category
- Average stock by price band
- Average stock by rating
- Average price by rating category
- Average price by stock status
- Average stock by category
- Average rating by price band
- Stock quantity distribution
- Price distribution by price band
- Stock quantity by rating category
- Top 10 most expensive books

These visualizations help identify pricing, rating, inventory, and category-level patterns.

The `charts/` folder contains the EDA visualizations along with the machine-learning and clustering visualizations.

---

# 🤖 6. Machine Learning — Book Segmentation

The machine-learning stage focuses primarily on **unsupervised learning using K-Means clustering**.

### ❓ Why K-Means Clustering?

The dataset does not contain a reliable supervised target variable for predicting a meaningful business outcome.

Therefore, instead of predicting a predefined target, K-Means was used to discover naturally occurring groups of books with similar characteristics.

The objective was to answer:

> **Which books have similar characteristics and can be grouped together?**

This provides an additional perspective for catalog and inventory analysis.

---

# 📌 7. Features Used for Clustering

The K-Means model uses six numerical features:

- `Price`
- `Rating`
- `Stock_Quantity`
- `Title_Length`
- `Description_Length`
- `Description_Word_Count`

Derived categorical features such as:

- `Price_Band`
- `Rating_Category`
- `Stock_Status`

were excluded from clustering to avoid using variables directly derived from the selected numerical features.

---

# 📏 8. Feature Scaling

The selected features have different numerical ranges.

For example:

- Rating has a relatively small numerical range.
- Price has a larger range.
- Stock quantity can vary considerably.
- Description length can contain hundreds of characters.

Therefore, **StandardScaler** was used before applying K-Means.

This puts the selected numerical features on a comparable scale so that larger-valued features do not dominate the clustering process.

---

# 🔢 9. Selecting the Number of Clusters

Multiple values of K were evaluated from **2 to 10**.

The following methods were used:

- Elbow Method
- Silhouette Score
- Davies-Bouldin Index
- Calinski-Harabasz Index
- Cluster stability analysis using Adjusted Rand Index

The Elbow Method did not show one sharply defined elbow, while **K=2 produced the highest numerical Silhouette Score**.

However, **K=3 was selected for the final segmentation because it provided more useful business differentiation for the book catalog while still producing a meaningful clustering structure.**

---

# 📚 10. Final Book Segments

The final K-Means model contains **three book segments**.

### 🟢 Cluster 0 — High-Stock Books

- **352 books**
- Average stock quantity: approximately **14.74**
- Relatively higher inventory levels
- Generally shorter content descriptions

**Potential business use:**

- Monitor inventory levels.
- Identify books with relatively high available stock.
- Compare pricing and ratings within this segment.

---

### 🔵 Cluster 1 — Low-Stock Books

- **497 books**
- Average stock quantity: approximately **3.99**
- Relatively lower inventory levels
- Generally shorter content descriptions

**Potential business use:**

- Monitor inventory more closely.
- Identify books with relatively low available stock.
- Compare pricing and ratings within this segment.

> **Note:** Low stock does not automatically mean high demand because the dataset does not contain actual sales or customer purchase data.

---

### 🟠 Cluster 2 — Detailed-Content Books

- **151 books**
- Moderate inventory levels
- Substantially longer titles and descriptions compared with the other clusters

**Potential business use:**

- Analyze product-page content.
- Compare content characteristics across books.
- Explore whether detailed product descriptions are associated with different pricing or rating patterns.

---

# 📌 11. Cluster Characteristics

The clustering analysis shows that:

- Average prices are relatively similar across the three clusters.
- Average ratings are also relatively similar across the clusters.
- Inventory characteristics show stronger differences between clusters.
- Title and description lengths contribute strongly to the distinction of the Detailed-Content Books segment.

This indicates that the segmentation is driven more by **inventory and content characteristics** than by price and rating alone.

---

# 📉 12. PCA Visualization

**Principal Component Analysis (PCA)** was used to visualize the six-dimensional clustering data in two dimensions.

PCA was used for **visualization purposes**, while K-Means clustering was performed on the standardized six-feature dataset.

The PCA projection provides a visual representation of how the book clusters are distributed.

---

# 🧪 13. Additional Machine Learning Experiments

The machine-learning notebook also explores supervised prediction experiments related to:

- Stock Status
- Price
- Rating

These experiments showed limited predictive performance with the available features.

Therefore, the **K-Means clustering approach was retained as the primary machine-learning component** of the project rather than relying on weak prediction results.

---

# 💼 14. Business Insights

The analysis provides several useful observations about the book catalog.

### 📌 Pricing

Book prices vary across the catalog and can be analyzed through price bands and category-level comparisons.

### 📌 Ratings

The dataset contains books across different rating levels, allowing comparisons between ratings, prices, stock levels, and categories.

### 📌 Inventory

Stock quantities vary considerably between books, making inventory-based segmentation useful.

### 📌 Product Content

Book titles and descriptions vary significantly in length.

This creates an opportunity to analyze product-content characteristics alongside pricing and inventory information.

### 📌 Book Segmentation

K-Means clustering identifies three broad groups based on price, rating, stock, and content-related characteristics.

These segments provide an additional analytical view of the catalog and can support further inventory and product-content analysis.

---

# 📊 15. Power BI Dashboard

The cleaned and clustered data was used to create an interactive Power BI dashboard.

The dashboard supports analysis of:

- Book pricing
- Ratings
- Stock availability
- Categories
- Price bands
- Rating categories
- Inventory
- Cluster distribution
- Book-level comparisons

Power BI provides an interactive way to explore the analytical results and communicate the findings.

Dashboard file:

`dashboard/dashboard.pbix`

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Python | Data collection, cleaning, analysis, and machine learning |
| Requests | Web requests during data collection |
| BeautifulSoup | HTML parsing and web scraping |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical operations |
| Matplotlib | Data visualization |
| Seaborn | Statistical visualization |
| MySQL | SQL-based data analysis |
| Scikit-learn | Scaling, clustering, PCA, and evaluation metrics |
| Jupyter Notebook | Development and analysis environment |
| Power BI | Interactive dashboard |

---

# 📁 Project Structure

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
    ├── notebook/
    │   ├── 01_Web_Data_Acquisition.ipynb
    │   ├── 02_Data_Cleaning_Preprocessing.ipynb
    │   ├── 03_SQL_Data_Analysis.ipynb
    │   ├── 04_EDA_Visualization.ipynb
    │   └── 05_Machine_Learning.ipynb
    │
    ├── SQL/
    │   └── SQL_data_analysis.sql
    │
    ├── dashboard/
    │   └── dashboard.pbix
    │
    └── charts/
        ├── EDA visualizations
        ├── clustering visualizations
        └── machine-learning evaluation charts

---

# ▶️ How to Run the Project

## 1. Clone the Repository

    git clone <your-github-repository-url>

    cd BookWise-E-Commerce-Book-Pricing-Rating-Analytics

## 2. Install Required Libraries

    pip install pandas numpy requests beautifulsoup4 matplotlib seaborn scikit-learn jupyter mysql-connector-python

## 3. Run the Notebooks

Run the notebooks in the following order:

    01_Web_Data_Acquisition.ipynb
    02_Data_Cleaning_Preprocessing.ipynb
    03_SQL_Data_Analysis.ipynb
    04_EDA_Visualization.ipynb
    05_Machine_Learning.ipynb

## 4. MySQL Configuration

The SQL analysis requires a MySQL database.

Configure your own local MySQL credentials before running the SQL notebook.

**Do not upload real database passwords or credentials to GitHub.**

Use environment variables or another local configuration method for your credentials.

Example:

    DB_HOST=localhost
    DB_USER=your_username
    DB_PASSWORD=your_password
    DB_NAME=bookwise_analytics

## 5. Open the Power BI Dashboard

Open:

    dashboard/dashboard.pbix

using Microsoft Power BI Desktop.

---

# ⚠️ Project Limitations

- The dataset contains 1,000 books from a web-scraping practice website.
- The data represents an online product catalog rather than actual transaction history.
- Actual sales volume and customer purchase behavior are not available.
- Low stock cannot be directly interpreted as high demand.
- The clustering results represent statistical similarities between books and should not be treated as confirmed business categories.
- K=3 was selected using both clustering evaluation and business interpretability rather than simply choosing the K value with the highest Silhouette Score.
- The dataset represents the catalog at the time of collection and may change over time.
- Power BI Desktop is required to open the `.pbix` dashboard.
- Some source-provided category values such as `"Add a comment"` were retained rather than manually assigning categories.

---

# 🚀 Future Improvements

The project could be extended with:

- Real sales and transaction data.
- Historical price data.
- Customer purchase behavior.
- Demand forecasting.
- Sales prediction using stronger business features.
- Book recommendation systems.
- Customer segmentation when customer-level data becomes available.
- Time-series analysis.
- Automated data-refresh pipelines.
- Cloud database integration.
- A web application for interactive book analytics.

---

# 🔑 Key Takeaways

This project demonstrates an end-to-end data analytics workflow:

**1. Data Collection**  
Collected book information from an online bookstore using web scraping.

**2. Data Cleaning**  
Cleaned inconsistent values, corrected data types, handled text issues, and validated the dataset.

**3. Feature Engineering**  
Created analytical features related to price, rating, inventory, and product content.

**4. SQL Analysis**  
Used MySQL to perform structured analysis and answer business-oriented questions.

**5. Exploratory Data Analysis**  
Used visualizations to identify pricing, rating, inventory, and category-level patterns.

**6. Machine Learning**  
Applied K-Means clustering to identify groups of similar books.

**7. Business Interpretation**  
Interpreted the resulting book segments from an inventory and product-content perspective.

**8. Dashboard Development**  
Created a Power BI dashboard to communicate the analytical findings interactively.

---

# 👩‍💻 Author

**Suhani**

Computer Science & Engineering

Interested in:

- Data Analytics
- Artificial Intelligence
- Machine Learning
- Business Intelligence
- Data-Driven Decision Making

---

# 📄 Disclaimer

This project was created for **educational and portfolio purposes**.

The dataset was collected from **Books to Scrape**, a website intended for web-scraping practice.

The insights presented in this project are based on the available catalog data and should not be treated as actual commercial recommendations without additional real-world business and transaction data.
