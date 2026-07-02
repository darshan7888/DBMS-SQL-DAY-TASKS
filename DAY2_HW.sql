

 Part A — The Client Story

Read the scenario carefully. You will use it to design a database and answer real-life questions from the client.

> Mr. Vikram Rao owns CineStar Multiplex, a 5-screen cinema in the middle of the city. He's just come back from a conference on digitizing your business and calls you in for a chat.

"Right now, everything at CineStar runs off a whiteboard and a bunch of Excel sheets, and honestly, it's falling apart. Let me explain.

We screen anywhere between 15 and 20 movies a month across our 5 screens — Hindi, English, regional films, you name it. Each movie has a title, a genre, a language, a duration, and a release date. My manager keeps forgetting which movie is running in which language on which screen, and last week we printed the wrong movie name on a customer's ticket.

Then there are the screens themselves. Screen 1 is our big Dolby Atmos screen with 200 seats. Screen 3 is a smaller 80-seat 3D screen. Each screen has its own seating capacity and screen type — that matters a lot, because a customer booking a 3D show needs to be put in a 3D-capable screen, not just any screen.

But the real headache is ticket booking. A customer calls (or walks in) and says, 'I want 2 tickets for the 7 PM show of the new Hindi movie on Saturday.' My cashier has no fast way to check how many seats are still free in that show, so we've sold more tickets than seats available — twice, in one month! We've had customers standing at the door with valid tickets and no seats to sit in. It's embarrassing.

I also want to know things like:
 We can look up any movie's details — genre, language, duration, release date.

 Which movie sold the most tickets this month?
 Which screen is under-used and maybe should be discontinued?
 How much revenue did we make from ticket sales yesterday?

Right now I can't answer any of this without going through paper records manually by hand.

I want a computer system where:

 We can look up any movie's details — genre, language, duration, release date.
 We can see every screen's capacity and type (2D / 3D / Dolby).
 We can book tickets and instantly know how many seats are left for a specific show.
 We can generate reports like 'most watched movie this month' or 'today's total ticket revenue' in seconds.

CREATE TABLE Movie (
    movie_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    genre VARCHAR2(50),
    language VARCHAR2(30),
    duration NUMBER,
    release_date DATE
);

CREATE TABLE Screen (
    screen_id NUMBER PRIMARY KEY,
    screen_name VARCHAR2(20),
    screen_type VARCHAR2(20),
    capacity NUMBER
);

CREATE TABLE Show_Details (
    show_id NUMBER PRIMARY KEY,
    movie_id NUMBER ,
    screen_id NUMBER ,
    show_date DATE,
    show_time VARCHAR2(10),
    ticket_price NUMBER,
    FOREIGN KEY(movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY(screen_id) REFERENCES Screen(screen_id)
);


CREATE TABLE Customer_(
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100),
    phone VARCHAR2(15)
);

CREATE TABLE Booking (
    booking_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    show_id NUMBER,
    no_of_tickets NUMBER,
    booking_date DATE,
    FOREIGN KEY(customer_id) REFERENCES Customer_(customer_id),
    FOREIGN KEY(show_id) REFERENCES Show_Details(show_id)
);

INSERT INTO Movie VALUES
(101,'Sitaare Zameen Par','Drama','Hindi',160,DATE '2025-06-10');

INSERT INTO Movie VALUES
(102,'Mission Impossible','Action','English',170,DATE '2025-05-20');

INSERT INTO Movie VALUES
(103,'Pushpa 2','Action','Telugu',180,DATE '2025-04-10');

INSERT INTO Screen VALUES(1,'Screen 1','Dolby',200);

INSERT INTO Screen VALUES(2,'Screen 2','2D',150);

INSERT INTO Screen VALUES(3,'Screen 3','3D',80);

INSERT INTO Screen VALUES(4,'Screen 4','2D',120);

INSERT INTO Screen VALUES(5,'Screen 5','3D',100);



INSERT INTO Show_Details VALUES
(201,101,1,DATE '2025-07-10','07:00 PM',250);

INSERT INTO Show_Details VALUES
(202,102,3,DATE '2025-07-10','09:00 PM',300);

INSERT INTO Show_Details VALUES
(203,103,5,DATE '2025-07-11','06:00 PM',280);


INSERT INTO Customer_ VALUES
(1,'Rahul','9876543210');

INSERT INTO Customer_ VALUES
(2,'Darshan','9876500000');

INSERT INTO Customer_ VALUES
(3,'Mohit','9999999999');

INSERT INTO Customer_ VALUES
(4,'Raju','9904058744');

INSERT INTO Booking VALUES
(1001,1,201,2,SYSDATE);

INSERT INTO Booking VALUES
(1002,2,201,3,SYSDATE);

INSERT INTO Booking VALUES
(1003,3,202,4,SYSDATE);


SELECT  FROM Movie;
SELECT  FROM Screen;
SELECT  FROM Show_Details;
SELECT  FROM Customer_;
SELECT  FROM Booking;


Query :- 

(1) We can look up any movie's details — genre, language, duration, release date.

SELECT title,
       genre,
       language,
       duration,
       release_date
FROM Movie;


TITLE
----------------------------------------------------------------------------------------------------
GENRE                                              LANGUAGE                         DURATION RELEASE_D
-------------------------------------------------- ------------------------------ ---------- ---------
Sitaare Zameen Par
Drama                                              Hindi                                 160 10-JUN-25

Mission Impossible
Action                                             English                               170 20-MAY-25

Pushpa 2
Action                                             Telugu                                180 10-APR-25


(2) Which movie sold the most tickets this month?

SELECT screen_name,
       screen_type,
       capacity
FROM Screen;

SCREEN_NAME          SCREEN_TYPE            CAPACITY
-------------------- -------------------- ----------
Screen 1             Dolby                       200
Screen 2             2D                          150
Screen 3             3D                           80
Screen 4             2D                          120
Screen 5             3D                          100


(3)  We can book tickets and instantly know how many seats are left for a specific show.

SELECT
s.screen_name,
s.capacity,
NVL(SUM(b.no_of_tickets),0) AS booked,
(s.capacity-NVL(SUM(b.no_of_tickets),0)) AS seats_left
FROM Screen s
JOIN Show_Details sh
ON s.screen_id=sh.screen_id
LEFT JOIN Booking b
ON sh.show_id=b.show_id
WHERE sh.show_id=201
GROUP BY s.screen_name,s.capacity;


SCREEN_NAME            CAPACITY     BOOKED SEATS_LEFT
-------------------- ---------- ---------- ----------
Screen 1                    200          5        195


(4) We can generate reports like most watched movie this month or today's total ticket revenue' in seconds.
-- SELECT m.title,
--        SUM(b.no_of_tickets) AS total_tickets
-- FROM Movie m
-- JOIN Show_Details s ON m.movie_id = s.movie_id
-- JOIN Booking b ON s.show_id = b.show_id
-- WHERE TO_CHAR(s.show_date, 'MMYYYY') = TO_CHAR(SYSDATE, 'MMYYYY')
-- GROUP BY m.title
-- ORDER BY total_tickets DESC;

-- SELECT SUM(b.no_of_tickets  s.ticket_price) AS total_revenue
-- FROM Booking b
-- JOIN Show_Details s
-- ON b.show_id = s.show_id
-- WHERE TRUNC(s.show_date) = TRUNC(SYSDATE);




