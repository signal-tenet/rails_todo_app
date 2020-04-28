<https://rg-test-task.herokuapp.com>

###SQL queries:###

Tables:
* tasks (id, name, status, project_id)
* projects (id, name)

1. get all statuses, not repeating, alphabetically ordered  
    ```sql
      SELECT DISTINCT status
      FROM tasks 
      ORDER BY status;
    ```
    
2. get the count of all tasks in each project, order by tasks count descending  
    ```sql
      SELECT COUNT() 
      FROM tasks 
      GROUP BY project_id 
      ORDER BY COUNT() DESC;
    ```

3. get the count of all tasks in each project, order by projects names  
    ```sql
      SELECT projects.name, COUNT() AS t_count
      FROM tasks INNER JOIN projects
      ON tasks.project_id = projects.id
      GROUP BY projects.id
      ORDER BY projects.name;
    ```

4. get the tasks for all projects having the name beginning with “N” letter 
    ```sql 
      SELECT * FROM tasks WHERE name LIKE 'N%';
    ```

5. get the list of all projects containing the ‘a’ letter in the middle of the name, and show the
tasks count near each project. Mention that there can exist projects without tasks and
tasks with project_id=NULL  
    ```sql
      SELECT projects.name, COUNT(tasks.id) 
      FROM projects INNER JOIN tasks ON projects.id = project_id 
      WHERE projects.name LIKE '_%a%_' 
      GROUP BY projects.name;
    ```

6. get the list of tasks with duplicate names. Order alphabetically  
    ```sql
      SELECT tasks.name, tasks.id 
      FROM tasks INNER JOIN (SELECT id, name FROM tasks GROUP BY name HAVING count(id) > 1) duplicate
      ON tasks.name = duplicate.name 
      ORDER BY tasks.name;
    ```

7. get the list of tasks having several exact matches of both name and status, from the
project ‘Garage’. Order by matches count  
    ```sql
      SELECT tasks.name
      FROM tasks INNER JOIN projects
      ON tasks.projects_id = projects.id
      WHERE projects.name = 'Garage'
      GROUP BY tasks.name, tasks.status
      HAVING COUNT(tasks) > 1
      ORDER BY COUNT(tasks);
    ```

8. get the list of project names having more than 10 tasks in status ‘completed’. Order by
project_id  
    ```sql
      SELECT projects.name
      FROM tasks INNER JOIN projects
      ON tasks.projects_id = projects.id
      WHERE tasks.status = 'completed'
      GROUP BY projects.id HAVING COUNT(tasks) > 10
      ORDER BY projects.id;
    ```