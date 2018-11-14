SELECT a.first_name FROM actor a
  GROUP BY a.first_name
  HAVING COUNT(a.actor_id) = (SELECT l1.db FROM leggyakoribbkeresztnevdb l1);