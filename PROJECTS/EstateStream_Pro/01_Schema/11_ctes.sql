WITH Investor_Stats AS (
    -- Chapter 1: Calculate basic totals per person
    SELECT 
        investor,
        COUNT(property) as deal_count,
        SUM(net_value) as total_equity
    FROM real_estate_pro.v_investor_summary
    GROUP BY investor
),
Market_Average AS (
    -- Chapter 2: Find the overall average deal size across the whole system
    SELECT AVG(net_value) as global_avg_deal
    FROM real_estate_pro.v_investor_summary
)
-- Chapter 3: Combine everything for the final Truth
SELECT 
    i.investor,
    i.deal_count,
    i.total_equity,
    ROUND(i.total_equity / i.deal_count, 2) as avg_deal_size,
    ROUND(m.global_avg_deal, 2) as market_avg,
    CASE 
        WHEN (i.total_equity / i.deal_count) > m.global_avg_deal THEN 'Above Market'
        ELSE 'Below Market'
    END AS performance_bracket
FROM Investor_Stats i
CROSS JOIN Market_Average m;