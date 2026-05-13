WITH Investor_Ranking AS (
    SELECT 
        investor,
        property,
        location,
        net_value,
        -- RANK 1: Global Rank (Across all cities)
        RANK() OVER (ORDER BY net_value DESC) as global_rank,
        -- RANK 2: City Rank (Who is #1 in Madrid, #1 in London, etc.)
        RANK() OVER (PARTITION BY location ORDER BY net_value DESC) as city_rank
    FROM real_estate_pro.v_investor_summary
)
SELECT * FROM Investor_Ranking
ORDER BY location, city_rank;