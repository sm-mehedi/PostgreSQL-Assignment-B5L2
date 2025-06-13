নিচে দেওয়া হয়েছে উপরের PostgreSQL বিষয়বস্তুর বাংলা অনুবাদ:

---

<h2>PostgreSQL এর প্রাথমিক ধারণা</h2>

<h3>PostgreSQL কী?</h3>
<p>
PostgreSQL একটি শক্তিশালী, ওপেন-সোর্স অবজেক্ট-রিলেশনাল ডেটাবেস সিস্টেম যা সম্প্রসারণযোগ্যতা ও উচ্চ পারফরম্যান্সের জন্য ডিজাইন করা হয়েছে। এটি JSON, ইনডেক্সিং এবং ফুল-টেক্সট সার্চের মতো আধুনিক ফিচার সমর্থন করে, যা এটিকে আধুনিক অ্যাপ্লিকেশনের জন্য আদর্শ করে তোলে। উদাহরণস্বরূপ:
</p>
<pre><code>CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  role VARCHAR(50)
);</code></pre>

<h3>PostgreSQL-এ প্রাইমারি কী এবং ফরেন কী কী?</h3>
<p>
<strong>প্রাইমারি কী</strong> কোনো টেবিলের প্রতিটি সারিকে অনন্যভাবে চিহ্নিত করে এবং এতে NULL বা ডুপ্লিকেট মান থাকতে পারে না। <strong>ফরেন কী</strong> একটি টেবিলকে অন্য টেবিলের সাথে যুক্ত করে এবং সম্পর্কযুক্ত ডেটার মধ্যে রেফারেনশিয়াল অখণ্ডতা (referential integrity) নিশ্চিত করে। উদাহরণস্বরূপ:
</p>
<pre><code>CREATE TABLE departments (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employees (
emp\_id SERIAL PRIMARY KEY,
emp\_name VARCHAR(100),
dept\_id INT REFERENCES departments(dept\_id)
);</code></pre>

<h3>VARCHAR এবং CHAR ডেটা টাইপের মধ্যে পার্থক্য কী?</h3>
<p>
<code>VARCHAR(n)</code> হল ভ্যারিয়েবল-দৈর্ঘ্যের স্ট্রিং, যেখানে সর্বোচ্চ <code>n</code> অক্ষর রাখা যায় — এটি জায়গা সাশ্রয়ী। অন্যদিকে <code>CHAR(n)</code> নির্দিষ্ট দৈর্ঘ্যের স্ট্রিং রাখে এবং প্রয়োজনে অতিরিক্ত অংশ স্পেস দিয়ে পূরণ করে, যা পারফরম্যান্স বা স্টোরেজে প্রভাব ফেলতে পারে। উদাহরণ:
</p>
<pre><code>CREATE TABLE test_types (
  short_name CHAR(5),
  full_name VARCHAR(50)
);</code></pre>

<h3>SELECT স্টেটমেন্টে WHERE ক্লজের ব্যবহার কী?</h3>
<p>
<code>WHERE</code> ক্লজ নির্দিষ্ট শর্ত অনুযায়ী ফলাফল ফিল্টার করে, যার মাধ্যমে নির্দিষ্ট ডেটা পুনরুদ্ধার করা যায় এবং পারফরম্যান্স উন্নত হয়। এটি অপ্রয়োজনীয় সারি লোড হওয়া থেকে রক্ষা করে। উদাহরণ:
</p>
<pre><code>SELECT * FROM employees
WHERE role = 'Developer' AND name LIKE 'M%';</code></pre>

<h2>PostgreSQL-এ <code>COUNT()</code>, <code>SUM()</code>, এবং <code>AVG()</code> এর মতো অ্যাগ্রিগেট ফাংশন কীভাবে ব্যবহার করবেন?</h2>

<p>
PostgreSQL-এ অ্যাগ্রিগেট ফাংশনের মাধ্যমে একটি নির্দিষ্ট সারির সেটের উপর গণনা করে একটি সারাংশ ফলাফল প্রদান করা হয়। এগুলো ডেটা বিশ্লেষণ এবং রিপোর্ট তৈরির জন্য অত্যন্ত গুরুত্বপূর্ণ।
</p>

<p>সাধারণত ব্যবহৃত কিছু অ্যাগ্রিগেট ফাংশন:</p>
<ul>
  <li><code>COUNT()</code>: কোনো কলামে বা শর্ত অনুযায়ী সারির সংখ্যা গণনা করে।</li>
  <li><code>SUM()</code>: একটি সংখ্যাসূচক কলামের মোট যোগফল নির্ণয় করে।</li>
  <li><code>AVG()</code>: একটি সংখ্যাসূচক কলামের গড় মান নির্ণয় করে।</li>
</ul>

<p>এই ফাংশনগুলো প্রায়ই <code>GROUP BY</code> ক্লজের সাথে ব্যবহার করা হয়, যাতে এক বা একাধিক কলাম অনুযায়ী গ্রুপ করে প্রতিটির জন্য পৃথক অ্যাগ্রিগেট মান নির্ণয় করা যায়।</p>

<p><strong>উদাহরণ:</strong> ধরুন আপনার কাছে <code>sightings</code> নামক একটি টেবিল আছে যার একটি সংখ্যাসূচক কলাম <code>quantity</code>। আপনি জানতে চান:</p>
<ul>
  <li>মোট কয়টি sighting হয়েছে (<code>COUNT</code>)</li>
  <li>সর্বমোট কতগুলো প্রাণী দেখা গেছে (<code>SUM</code>)</li>
  <li>প্রতি sighting-এ গড় প্রাণীর সংখ্যা কত (<code>AVG</code>)</li>
</ul>

<pre><code>SELECT 
  COUNT(*) AS total_sightings,
  SUM(quantity) AS total_quantity,
  AVG(quantity) AS average_quantity
FROM sightings;</code></pre>

<p><code>GROUP BY</code> ব্যবহার করে আপনি প্রতিটি species বা ranger অনুযায়ী অ্যাগ্রিগেট মান বের করতে পারেন:</p>

<pre><code>SELECT 
  species_id,
  COUNT(*) AS total_sightings,
  AVG(quantity) AS avg_quantity
FROM sightings
GROUP BY species_id;</code></pre>

<p>সারাংশে, অ্যাগ্রিগেট ফাংশনগুলো ডেটা সহজভাবে বিশ্লেষণ করতে সাহায্য করে এবং ডেটাসেট থেকে মোট, গড় ও সংখ্যা নির্ণয়ের মাধ্যমে গুরুত্বপূর্ণ তথ্য প্রদান করে।</p>
