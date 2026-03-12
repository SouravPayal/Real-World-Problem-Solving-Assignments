// Load the client data from the CSV file and create Client nodes with their details (id, name, email, phone, tfn)
LOAD CSV WITH HEADERS FROM 'file:///clients.csv' AS row
CREATE (:Client {
id: row.id,
name: row.name,
email: row.email,
phone: row.phone,
tfn: row.tfn
});

// Load the client data again and create relationships between Client nodes and their associated Phone, Email, and TFN nodes
LOAD CSV WITH HEADERS FROM 'file:///clients.csv' AS row
MERGE (c:Client {id: row.id})
MERGE (p:Phone {number: row.phone})
MERGE (e:Email {address: row.email})
MERGE (t:TFN {tfn: row.tfn})
MERGE (c)-[:HAS_PHONE]->(p) // Create relationship to phone number
MERGE (c)-[:HAS_EMAIL]->(e) // Create relationship to email address
// Create relationship to TFN
MERGE (c)-[:HAS_TFN]->(t); 

// Load the seller/store data from the CSV file and create Seller nodes with id and name
LOAD CSV WITH HEADERS FROM 'file:///stores.csv' AS row
CREATE (:Seller {id: row.id, name: row.name});

// Load purchase transaction data from the CSV file and create Purchase Transaction nodes
LOAD CSV WITH HEADERS FROM 'file:///purchase.csv' AS row
MATCH (c:Client {id: row.idFrom}), (s:Seller {id: row.idTo}) // Match client and seller by id
CREATE (t:Transaction:Purchase {amount: toFloat(row.amount), time: datetime({epochSeconds: toInteger(row.timeOffset) + 1715436000})}) // Create Purchase Transaction node
MERGE (c)-[:PERFORMED]->(t) // Create relationship from client to transaction
// Create relationship from transaction to seller
MERGE (t)-[:TO]->(s); 

// Load transfer transaction data from the CSV file and create Transfer Transaction nodes
LOAD CSV WITH HEADERS FROM 'file:///xfer.csv' AS row
MATCH (sender:Client {id: row.idFrom}), (recipient:Client {id: row.idTo}) // Match sender and recipient clients by id
CREATE (t:Transaction:Transfer {amount: toFloat(row.amount), time: datetime({epochSeconds: toInteger(row.timeOffset) + 1702396800})}) // Create Transfer Transaction node
MERGE (sender)-[:PERFORMED]->(t) // Create relationship from sender to transaction
// Create relationship from transaction to recipient
MERGE (t)-[:TO]->(recipient); 

// Add unique constraints for each identifier to ensure data integrity
// Ensure Client id is unique
CREATE CONSTRAINT FOR (c:Client) REQUIRE c.id IS UNIQUE; 
// Ensure Seller id is unique
CREATE CONSTRAINT FOR (s:Seller) REQUIRE s.id IS UNIQUE; 
// Ensure Phone number is unique
CREATE CONSTRAINT FOR (p:Phone) REQUIRE p.number IS UNIQUE; 
// Ensure Email address is unique
CREATE CONSTRAINT FOR (e:Email) REQUIRE e.address IS UNIQUE; 
// Ensure TFN is unique
CREATE CONSTRAINT FOR (t:TFN) REQUIRE t.tfn IS UNIQUE; 

// Visualize the graph metadata and relationships using APOC
CALL apoc.meta.graph();

Part 2. Initial Queries (35%) 
•	Problem 1 (5%):
// Find the client who spent the most on purchases between 10am and 2pm on May 12, 2024
MATCH (c:Client)-[:PERFORMED]->(p:Purchase)
WHERE p.time >= datetime({epochSeconds: 1715436000 + 36000}) AND p.time <= datetime({epochSeconds: 1715436000 + 50400})
WITH c, sum(p.amount) AS total
RETURN c.name AS name, total
ORDER BY total DESC
LIMIT 1;
•	Problem 2 (10%): 
// Calculate outgoing amounts for each client (including both purchases and transfers)
MATCH (c:Client)-[:PERFORMED]->(t:Transaction)
WITH c, sum(t.amount) AS total_outgoing, max(t.amount) AS max_spent

// Calculate incoming transfer amounts for each client (optional match for clients with no incoming transfers)
OPTIONAL MATCH (c)<-[:TO]-(t_in:Transfer)
WITH c, total_outgoing, max_spent, coalesce(sum(t_in.amount), 0) AS total_incoming

// Compute the net cashflow (total incoming minus total outgoing) and filter for clients with negative cash flow
WITH c, total_incoming, total_outgoing, max_spent, (total_incoming - total_outgoing) AS net_cashflow
WHERE net_cashflow < 0
RETURN c.name AS name, net_cashflow AS balance, max_spent AS big_spend
ORDER BY net_cashflow
LIMIT 5;
•	Problem 3 (10%): 
// Analyze the ratio of purchase amounts at a specific seller compared to total incoming transfer amounts
MATCH (c:Client)<-[:TO]-(transfer:Transaction:Transfer)
WITH c, sum(transfer.amount) AS total_xfer
MATCH (c)-[:PERFORMED]->(purchase:Transaction:Purchase)-[:TO]->(s:Seller {name: 'Woods'})
WITH c.name AS name, total_xfer, sum(purchase.amount) AS total_purchase
WHERE total_purchase >= 0.05 * total_xfer
RETURN name, (total_purchase / total_xfer) * 100 AS percentage, total_xfer, total_purchase
ORDER BY percentage DESC;
•	Problem 4 (10%): 
// Match all clients and their associated transactions
MATCH (c:Client)-[:PERFORMED]->(t:Transaction)
WITH c, t
ORDER BY t.time 
WITH c, collect(t) AS transactions 

// Create relationships between consecutive transactions
UNWIND range(0, size(transactions)-2) AS i
WITH c, transactions, transactions[i] AS current_transaction, transactions[i+1] AS next_transaction
MERGE (current_transaction)-[:NEXT]->(next_transaction) 

// Identify and link the first and last transactions for each client
WITH c, transactions
WITH c, transactions[0] AS first_transaction, transactions[size(transactions)-1] AS last_transaction

// Create relationships from the client to the first and last transactions in their transaction history
MERGE (c)-[:FIRST_TX]->(first_transaction) 
MERGE (c)-[:LAST_TX]->(last_transaction);

// Match the client 'Jacob Weiss' and find the first transaction they performed
MATCH (c:Client {name: 'Jacob Weiss'})-[:FIRST_TX]->(firstTx)

// Match the transaction path, starting from the first transaction and following all 'NEXT' relationships
MATCH path = (firstTx)-[:NEXT*]->(lastTx)
WITH c, path

// Optionally match any 'PERFORMED' relationships from the client to remove them
OPTIONAL MATCH (c)-[r:PERFORMED]->()
DELETE r

// Return the client, the transactions in the matched path, and the 'NEXT' relationships between transactions
RETURN c, 
nodes(path) AS transactions, 
[rel IN relationships(path) WHERE type(rel) = 'NEXT'] AS nextRelationships;

