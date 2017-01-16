
--drop table tb_temp_course

create table tb_temp_course
(
	courseA varchar(50),
	points varchar(50),
	title varchar(1000),
	[description] varchar(1000),
	prerequisite varchar(1000),
	Restriction varchar(1000)
)
go

select * from  tb_temp_course 

select courseA, prerequisite
from tb_temp_course 
where courseA = 'PHYSICS 203'
--truncate table tb_temp_course
 
 