<h2>📘 PostgreSQL Essentials</h2>

<h3>🔹 What is PostgreSQL?</h3>
<p>
PostgreSQL is a robust, open-source object-relational database system designed for extensibility and high performance. It supports advanced features like JSON, indexing, and full-text search, making it ideal for modern applications. For example:
</p>
<pre><code>CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  role VARCHAR(50)
);</code></pre>

<h3>🔹 Explain the Primary Key and Foreign Key concepts in PostgreSQL.</h3>
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

<h3>🔹 What is the difference between the VARCHAR and CHAR data types?</h3>
<p>
<code>VARCHAR(n)</code> stores variable-length strings up to <code>n</code> characters, making it space-efficient. <code>CHAR(n)</code> stores fixed-length strings and pads with spaces if needed, which can impact performance or storage. Example:
</p>
<pre><code>CREATE TABLE test_types (
  short_name CHAR(5),
  full_name VARCHAR(50)
);</code></pre>

<h3>🔹 Explain the purpose of the WHERE clause in a SELECT statement.</h3>
<p>
The <code>WHERE</code> clause filters results based on specific conditions, allowing precise data retrieval and better performance. It helps avoid loading unnecessary rows. For example:
</p>
<pre><code>SELECT * FROM employees
WHERE role = 'Developer' AND name LIKE 'M%';</code></pre>
