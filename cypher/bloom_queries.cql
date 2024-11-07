////////////////////////////////////////////////////////////////////////////////
// bloom_queries.cql - This script contains queries that power the bloom demo.
//
// AUTHOR: Pete Tunkis (tunkisp)
// DATE: 2024-10-29
//
// REVISION HISTORY
//
// tunkisp    2024-11-06    Adjust bloom query for fuller return.
//
////////////////////////////////////////////////////////////////////////////////

////////Show me a small tech startup with Canadian presence
////Demo query!

//Cypher query
MATCH p = (r1:Respondent)-[u1:USES]->(t:Tool)<-[u2:USES]-(r2:Respondent)-[s:SIMILAR_TO]-(r1)
WHERE r1 <> r2
    AND "Tech" IN r1.industry
    AND "Start-up or small corporation" IN r1.business
    AND ("Canada" IN r1.participants 
            OR "Canada" IN r1.researchers)
    AND r1.num_researchers = "2-5"
    AND r1.discipline = "User or design research"
    AND (u1.use_case = "Research planning" 
            OR u1.use_case = "Research roadmapping")
    AND u1.use_case = u2.use_case
RETURN p

////////Show me all use cases for tool: $tool
////Tool: Use Case Exploration

//Cypher query
MATCH p = (:Respondent)-[u:USES]->(t:Tool)
WHERE t.tool = $tool
RETURN DISTINCT p

//Parameter query
MATCH (t:Tool)
RETURN DISTINCT t.tool

////////Show me all tools for use case: $use_case
////Use Case: Tools Exploration

//Cypher query
MATCH ()-[u:USES]->(t:Tool)
WHERE u.use_case = $use_case
RETURN DISTINCT t

//Parameter query
MATCH ()-[u:USES]-()
RETURN DISTINCT u.use_case