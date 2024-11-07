////////////////////////////////////////////////////////////////////////////////
// neodash_queries.cql - This script contains queries that power the demo 
//                       neodash.
//
// AUTHOR: Pete Tunkis (tunkisp)
// DATE: 2024-10-23
//
// REVISION HISTORY
//
// tunkisp    2024-11-07    Commenting out use cases by tool--leaving for 
//                          reference/use with parameterized filters?
//
////////////////////////////////////////////////////////////////////////////////

//////// SINGLE VALUES

//// Total Respondents
MATCH (r:Respondent)
RETURN COUNT(r)

//// Total Unique Tools
MATCH (t:Tool)
RETURN COUNT(DISTINCT t)

//// Total Unique Use Cases
MATCH (:Tool)<-[u:USES]-()
RETURN COUNT(DISTINCT u.use_case)

//////// DESCRIPTIVE VIZ

//// Tools, Use Cases

// Number of use-cases by tool
//MATCH (t:Tool)<-[u:USES]-()
//RETURN t.tool AS Tool // Category
//    , COUNT(u) AS `Use Cases` // Value
//    , u.use_case AS `Use Case` // Group

// Number of tools by use-case
MATCH (t:Tool)<-[u:USES]-()
RETURN u.use_case AS `Use Case` // Category
    , COUNT(t) AS Tools // Value
    , t.tool AS Tool // Group

//// Respondent Demographics

// Length of Experience
MATCH (r:Respondent)
RETURN r.len_experience AS `Length of Experience` // Category
    , COUNT(r.len_experience) AS Respondents // Value
    , r.exp_cat // Hidden for ordering
ORDER BY r.exp_cat DESC

// Maturity


// Number of Researchers (Size)
MATCH (r:Respondent)
RETURN r.num_researchers AS `Team Size` // Category
    , COUNT(r.num_researchers) AS Respondents // Value
    , r.size_cat // Hidden for ordering
ORDER BY r.size_cat DESC

// Type of business
MATCH (b:Business)<-[]-(r:Respondent)
RETURN b.business AS `Business Type` // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

// Type of company
MATCH (c:Company)<-[]-(r:Respondent)
RETURN c.company AS `Company Type` // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

// Respondent Discipline
MATCH (d:Discipline)<-[]-(r:Respondent)
RETURN d.discipline AS Discipline // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

// Type of industry
MATCH (i:Industry)<-[]-(r:Respondent)
RETURN i.industry AS Industry // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

// Respondent Responsibilities
MATCH (resp:Responsibility)<-[]-(r:Respondent)
RETURN resp.responsibility AS Responsibility // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

// Participant Locations
MATCH (l:Location)<-[:HAS_PARTICIPANTS_IN]-(r:Respondent)
RETURN l.location AS Location // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

// Researcher Locations
MATCH (l:Location)<-[:HAS_RESEARCHERS_IN]-(r:Respondent)
RETURN l.location AS Location // Category
    , COUNT(DISTINCT r) AS Respondents // Value
    // Group

//////// CHOROPLETH MAPS

// Participant Locations
MATCH (l:Location)<-[:HAS_PARTICIPANTS_IN]-(r:Respondent)
WHERE l.code IS NOT NULL
RETURN l.code AS Code // Category
    , COUNT(DISTINCT r) AS Respondents // Value

// Researcher Locations
MATCH (l:Location)<-[:HAS_RESEARCHERS_IN]-(r:Respondent)
WHERE l.code IS NOT NULL
RETURN l.code AS Code // Category
    , COUNT(DISTINCT r) AS Respondents // Value