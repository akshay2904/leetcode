select st.student_id, st.student_name, sb.subject_name, count(e.subject_name) as attended_exams
from Students st 
cross join Subjects sb
left join Examinations e
on st.student_id = e.student_id 
and sb.subject_name = e.subject_name
group by student_id, subject_name
order by student_id, subject_name