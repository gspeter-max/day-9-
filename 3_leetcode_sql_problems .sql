
'''1789. Primary Department for Each Employee'''
https://leetcode.com/problems/primary-department-for-each-employee/
select employee_id, department_id 
from employee 
where primary_flag = 'Y'


union all 


select employee_id , deapartment_id 
from employee 
group by employee_id  
having count(department_id) = 1 ; 




'''1795. Rearrange Products Table'''
https://leetcode.com/problems/rearrange-products-table/

select product_id , 'store1' as store , store1 as price
from products 
where store1 is not null 

union all 

select product_id, 'store2' as store , store2 as price
from products 
where store2 is not null 

union all 

select product_id, 'store3' as store , store3 as price 
from products 
where store3 is not null ; 




'''1873. Calculate Special Bonus'''

https://leetcode.com/problems/calculate-special-bonus/
select employee_id ,
	case when employee_id % 2 = 0 then 0 
	when substring(name , 1, 1) = 'M' then 0 
	else salary end as bonus 
from employees 
order by employee_id ; 
