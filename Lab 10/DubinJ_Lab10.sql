/*
   -----------------------------------------------------------------------------
   Programmer's Name: Justin Dubin
   Course: CSCI 2020 Section Number: 201
   Creation Date: 04/07/2022 Date of Last Modification: 04/07/2022
   E-mail Address:dubinj@etsu.edu
   ----------------------------------------------------------------------------
   Purpose -
       Lab 10 – SQL DDL
   -----------------------------------------------------------------------------
   Identifier dictionary -
       Not Applicable
   -----------------------------------------------------------------------------
   Notes and Assumptions – 
   -----------------------------------------------------------------------------
*/

 -- 1.1: Create Artist Table
   DROP TABLE Artist CASCADE CONSTRAINTS;
   
   CREATE TABLE Artist (
       Artist_ID NUMBER(5,0),
       First_Name VARCHAR2(15) NOT NULL,
       Last_Name VARCHAR2(15) NOT NULL,
       Street VARCHAR2(25) NOT NULL,
       City VARCHAR2(15) NOT NULL,
       State CHAR(2) NOT NULL,
       DateofBirth DATE
);
   
 -- 1.2: Select Artist Table
   SELECT * FROM Artist;
   
 -- 1.3a: ALTER the Artist Table to add a primary key
          ALTER TABLE Artist
ADD(CONSTRAINT artist_pk PRIMARY KEY (Artist_ID)
);

-- 1.3b: DROP and re-create the Artist Table to add a primary key
          DROP TABLE Artist CASCADE CONSTRAINTS;
          CREATE TABLE Artist (
              Artist_ID NUMBER(5,0),
              First_Name VARCHAR2(15) NOT NULL,
              Last_Name VARCHAR2(15) NOT NULL,
              Street VARCHAR2(25) NOT NULL,
              City VARCHAR2(15) NOT NULL,
              State CHAR(2) NOT NULL,
              DateofBirth DATE,
             CONSTRAINT artist_pk
                 PRIMARY KEY (Artist_ID)
);

-- 1.4a: ALTER Artist Table to Add the ZIP column
    ALTER TABLE Artist ADD (
    ZIP VARCHAR2(5)
    );
    
-- 1.4b: DROP and ReCREATE the Artist Table with a New Column
    DROP TABLE Artist CASCADE CONSTRAINTS;
          CREATE TABLE Artist (
              Artist_ID NUMBER(5,0),
              First_Name VARCHAR2(15) NOT NULL,
              Last_Name VARCHAR2(15) NOT NULL,
              Street VARCHAR2(25) NOT NULL,
              City VARCHAR2(15) NOT NULL,
              State CHAR(2) NOT NULL,
              ZIP VARCHAR(5) NOT NULL,
              DateofBirth DATE,
             CONSTRAINT artist_pk
                 PRIMARY KEY (Artist_ID)
);

/* 1.5: Why use ALTER instead of DROP and (re)CREATE?
                It is better to Alter the Table if the table already has a large 
            amount of data inside of it. 
*/

-- 1.6: Indexing the Artist’s Last Name
       CREATE INDEX IDX_ArtistLastName ON Artist(Last_Name);
      
/**********************************************/
       /** PART 2: Creating the Art Gallery Database **/
DROP TABLE Collector CASCADE CONSTRAINTS;
          CREATE TABLE Collector (
              Collector_ID NUMBER(5,0),
              First_Name VARCHAR2(15) not null,
              Last_Name VARCHAR2(15) not null,
              Street VARCHAR2(25) NOT NULL,
              City VARCHAR2(15) not null,
              State CHAR(2) NOT NULL,
              ZIP VARCHAR(5) NOT NULL,
              Phone NUMBER(10),
             CONSTRAINT Collector_pk
                 PRIMARY KEY (Collector_ID)
);   

DROP TABLE Curator CASCADE CONSTRAINTS;
          CREATE TABLE Curator (
              Curator_ID NUMBER(5,0),
              First_Name VARCHAR2(15) NOT NULL,
              Last_Name VARCHAR2(15) NOT NULL,
              Phone NUMBER(10) NOT NULL,
              Email VARCHAR2(35) NOT NULL,
              Join_Date DATE NOT NULL,
              Employment_Tyle CHAR(2),
              Salary NUMBER(8,2) NOT NULL,
             CONSTRAINT Curator_pk
                 PRIMARY KEY (Curator_ID)
);   

DROP TABLE Exhibition CASCADE CONSTRAINTS;
          CREATE TABLE Exhibition (
              Exhibition_ID NUMBER(9,0),
              Exhibition_Name VARCHAR2(40) NOT NULL,
              Type VARCHAR2(15) NOT NULL,
              Start_Date DATE,
              End_Date DATE,
              Entry_Type CHAR(1),
              Hours_Open VARCHAR2(13),
              Curator NUMBER(5,0) NOT NULL,
             CONSTRAINT Exhibition_pk
                 PRIMARY KEY (Exhibition_ID),
             CONSTRAINT Curator_fk
                 FOREIGN KEY (Curator)   REFERENCES Curator(Curator_ID)
);   

DROP TABLE Hall CASCADE CONSTRAINTS;
          CREATE TABLE Hall (
              Hall_Name VARCHAR2(20),
              Hall_Desc VARCHAR2(150),
              Hall_Size NUMBER(7,0) NOT NULL,
              Status CHAR(2) NOT NULL,
              Exhibition_ID NUMBER(9,0),
             CONSTRAINT Hall_pk
                 PRIMARY KEY (Hall_Name),
             CONSTRAINT Exhibition_fk
                 FOREIGN KEY (Exhibition_ID)   REFERENCES Exhibition(Exhibition_ID)
);   

DROP TABLE Artwork CASCADE CONSTRAINTS;
          CREATE TABLE Artwork (
              Title VARCHAR2(50),
              Artwork_Desc VARCHAR2(150),
              Artwork_Size VARCHAR2(10) NOT NULL,
              Artwork_Medium VARCHAR2(20) NOT NULL,
              Artist NUMBER(5,0) NOT NULL,
              Hall VARCHAR(20),
              Collector NUMBER(5,0),
             CONSTRAINT artwork_pk
                 PRIMARY KEY (Title),
            CONSTRAINT artist_fk
                 FOREIGN KEY (Artist)   REFERENCES Artist(Artist_ID),
            CONSTRAINT hall_fk
                 FOREIGN KEY (Hall)   REFERENCES Hall(Hall_Name),
            CONSTRAINT collector_fk
                 FOREIGN KEY (Collector) REFERENCES Collector(Collector_ID)          
);     

DROP TABLE Membership CASCADE CONSTRAINTS;
          CREATE TABLE Membership (
              Membership_ID NUMBER(4,0),
              Membership_Desc VARCHAR2(100),
              Start_Date DATE NOT NULL,
              End_Date DATE NOT NULL,
              Collector_ID NUMBER(5,0) NOT NULL,
             CONSTRAINT Membership_pk
                 PRIMARY KEY (Membership_ID),
             CONSTRAINT coll_mem_fk
                 FOREIGN KEY (Collector_ID)   REFERENCES Collector(Collector_ID)
);   

DROP TABLE Visitor CASCADE CONSTRAINTS;
          CREATE TABLE Visitor (
              Visitor_ID NUMBER(10,0),
              First_Name VARCHAR2(15) NOT NULL,
              Last_Name VARCHAR2(15) NOT NULL,
              Street VARCHAR2(25),
              City VARCHAR2(15),
              Visitor_State CHAR(2),
              ZIP NUMBER(5,0),
              Phone NUMBER(10),
              Email VARCHAR2(35),
             CONSTRAINT Visitor_pk
                 PRIMARY KEY (Visitor_ID)
);   

DROP TABLE Ticket CASCADE CONSTRAINTS;
          CREATE TABLE Ticket (
              Exhibition_ID NUMBER(9,0),
              Ticket_No NUMBER(15,0),
              Purchase_Date DATE NOT NULL,
              Visitor_ID NUMBER(10,0),
              Collector_ID NUMBER(5,0) NOT NULL,
              CONSTRAINT exhibit_pk 
                PRIMARY KEY(Exhibition_ID, Ticket_No),
              CONSTRAINT visitor_fk
                 FOREIGN KEY (Visitor_ID)   REFERENCES Visitor(Visitor_ID)
); 

DROP TABLE Art_Exhibit CASCADE CONSTRAINTS;
          CREATE TABLE Art_Exhibit (
              Exhibition_ID NUMBER(9,0),
              Artwork_Name VARCHAR2(50),
              CONSTRAINT ART_exhibit_pk 
                PRIMARY KEY(Exhibition_ID, Artwork_Name),
                CONSTRAINT exhibition_fk_2
                 FOREIGN KEY (Exhibition_ID)   REFERENCES Exhibition(Exhibition_ID),
              CONSTRAINT artwork_fk_2
                 FOREIGN KEY (Artwork_Name)   REFERENCES Artwork(Title)
); 