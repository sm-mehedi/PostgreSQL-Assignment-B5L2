<h2> PostgreSQL Essentials</h2>

<h3>What is PostgreSQL?</h3>
<p>
PostgreSQL is a robust, open-source object-relational database system designed for extensibility and high performance. It supports advanced features like JSON, indexing, and full-text search, making it ideal for modern applications. For example:
</p>
<pre><code>CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  role VARCHAR(50)
);</code></pre>

<h3>Explain the Primary Key and Foreign Key concepts in PostgreSQL.</h3>
<p>
A <strong>Primary Key</strong> uniquely identifies each row in a table and does not allow NULLs or duplicates. A <strong>Foreign Key</strong> links one table to another, ensuring referential integrity between related data. For example:
</p>
<pre><code>CREATE TABLE departments (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employees (
  emp_id SERIAL PRIMARY KEY,
  emp_name VARCHAR(100),
  dept_id INT REFERENCES departments(dept_id)
);</code></pre>

<h3>What is the difference between the VARCHAR and CHAR data types?</h3>
<p>
<code>VARCHAR(n)</code> stores variable-length strings up to <code>n</code> characters, making it space-efficient. <code>CHAR(n)</code> stores fixed-length strings and pads with spaces if needed, which can impact performance or storage. Example:
</p>
<pre><code>CREATE TABLE test_types (
  short_name CHAR(5),
  full_name VARCHAR(50)
);</code></pre>

<h3>Explain the purpose of the WHERE clause in a SELECT statement.</h3>
<p>
The <code>WHERE</code> clause filters results based on specific conditions, allowing precise data retrieval and better performance. It helps avoid loading unnecessary rows. For example:
</p>
<pre><code>SELECT * FROM employees
WHERE role = 'Developer' AND name LIKE 'M%';</code></pre>

 <h2>How can you calculate aggregate functions like <code>COUNT()</code>, <code>SUM()</code>, and <code>AVG()</code> in PostgreSQL?</h2>
  
  <p>
    Aggregate functions in PostgreSQL allow you to perform calculations on a set of rows and return a single summarized value. They are essential for data analysis and reporting.
  </p>

  <p>Here are the most common aggregate functions:</p>
  <ul>
    <li><code>COUNT()</code>: Counts the number of rows that match a condition or in a column.</li>
    <li><code>SUM()</code>: Calculates the total sum of a numeric column.</li>
    <li><code>AVG()</code>: Computes the average (mean) value of a numeric column.</li>
  </ul>

  <p>These functions are often used with the <code>GROUP BY</code> clause to group data by one or more columns and calculate aggregates for each group.</p>
  
  <p><strong>Example:</strong> Suppose you have a table <code>sightings</code> with a numeric column <code>quantity</code>, and you want to find:</p>
  <ul>
    <li>Total number of sightings (<code>COUNT</code>)</li>
    <li>Total quantity of animals seen (<code>SUM</code>)</li>
    <li>Average quantity per sighting (<code>AVG</code>)</li>
  </ul>

  <pre><code>SELECT 
    COUNT(*) AS total_sightings,
    SUM(quantity) AS total_quantity,
    AVG(quantity) AS average_quantity
  FROM sightings;</code></pre>

  <p>Using <code>GROUP BY</code> you can get aggregates per species or ranger:</p>

  <pre><code>SELECT 
    species_id,
    COUNT(*) AS total_sightings,
    AVG(quantity) AS avg_quantity
  FROM sightings
  GROUP BY species_id;</code></pre>

  <p>In summary, aggregate functions help you summarize data efficiently and gain insights like totals, counts, and averages from your dataset.</p>
</body>
