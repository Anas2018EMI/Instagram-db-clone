-- We want to reward our users who have been around the longest. Find oldest users.

SELECT username  FROM users ORDER by created_at LIMIT 5 ;

-- What day of the week do most users register on? We need to figure out when to schedule an ad campaign.

SELECT  DAYNAME(created_at ) AS day, COUNT(DAYNAME(created_at)) AS num_registrations FROM users GROUP BY day ORDER by num_registrations DESC;

-- We want to target our inactive users with an email campaign. Find the users who have never posted a photo

SELECT username FROM users LEFT JOIN photos ON users.id=user_id WHERE image_url IS NULL;

-- We're running a new contest to see who can get the most likes on a single photo. Who won?

SELECT username FROM users JOIN photos ON users.id=user_id WHERE photos.id=(SELECt photo_id FROM likes GROUP BY photo_id ORDER BY COUNT(*)DESC LIMIT 1);

-- Our investors want to know ... how many times does the average user post?

SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 
                          
-- A brand wants to know which hashtags to use in a post. what are the top 5 most commonly used hashtags?

SELECT tag_name, COUNT(tag_id)   FROM tags JOIN photo_tags ON tag_id = tags.id GROUP BY tag_id ORDER BY COUNT(tag_id) DESC LIMIT 5;

-- We have a small problem with bots on our site... Find users who had liked every single photo on the site.

SELECT username FROM likes JOIN users ON users.id=user_id GROUP BY user_id HAVING COUNT(*)= (SELECT COUNT(*) FROM photos);
