USE [master]
GO
/****** Object:  Database [EventManagementSystem]    Script Date: 4/24/2019 12:02:51 AM ******/
CREATE DATABASE [EventManagementSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EventManagementSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EventManagementSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EventManagementSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EventManagementSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EventManagementSystem] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EventManagementSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EventManagementSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EventManagementSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EventManagementSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EventManagementSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EventManagementSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [EventManagementSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EventManagementSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EventManagementSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EventManagementSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EventManagementSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EventManagementSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EventManagementSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EventManagementSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EventManagementSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EventManagementSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EventManagementSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EventManagementSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EventManagementSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EventManagementSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EventManagementSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EventManagementSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EventManagementSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EventManagementSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EventManagementSystem] SET  MULTI_USER 
GO
ALTER DATABASE [EventManagementSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EventManagementSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EventManagementSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EventManagementSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EventManagementSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EventManagementSystem] SET QUERY_STORE = OFF
GO
USE [EventManagementSystem]
GO
/****** Object:  Table [dbo].[EventUsers]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventUsers](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](255) NULL,
	[UserEmailAddress] [varchar](255) NULL,
	[UserMobileNumber] [varchar](255) NULL,
	[Age] [numeric](18, 0) NOT NULL,
	[Created_Timestamp] [datetime] NULL,
	[Modified_Timestamp] [datetime] NULL,
	[Created_By] [varchar](255) NULL,
	[Modified_By] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[TicketType] [varchar](255) NULL,
	[TicketCount] [numeric](18, 0) NOT NULL,
	[TicketPrice] [int] NOT NULL,
	[TicketAmount] [decimal](18, 2) NOT NULL,
	[Created_Timestamp] [datetime] NULL,
	[Modified_Timestamp] [datetime] NULL,
	[Created_By] [varchar](255) NULL,
	[Modified_By] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Abovethreetimesusers]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE VIEW [dbo].[Abovethreetimesusers] AS
SELECT u.UserName
FROM  
 dbo.Tickets T  join dbo.EventUsers U (NOLOCK) ON T.UserId = u.UserId
 group by u.UserName having count(t.userid) >=3
GO
/****** Object:  Table [dbo].[Events]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](255) NULL,
	[EventDescription] [varchar](max) NULL,
	[EventTime] [datetime] NULL,
	[EventLocation] [varchar](255) NULL,
	[EventPolicy] [varchar](255) NULL,
	[EventCapacity] [int] NULL,
	[Created_Timestamp] [datetime] NULL,
	[Created_By] [varchar](255) NULL,
	[Modified_Timestamp] [datetime] NULL,
	[Modified_By] [varchar](255) NULL,
	[IsCancelled] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sponsors]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sponsors](
	[SponsorId] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NOT NULL,
	[SponsorName] [varchar](255) NULL,
	[Sponsor Description] [varchar](max) NULL,
	[Price] [numeric](18, 0) NULL,
	[Created_Timestamp] [datetime] NULL,
	[Created_By] [varchar](255) NULL,
	[Modified_Timestamp] [datetime] NULL,
	[Modified_By] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SponsorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[EventManagementReport]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EventManagementReport] AS
SELECT E.EventName,E.EventLocation,T.TicketPrice,T.TicketAmount,U.username,U.Age,s.SponsorName
FROM  dbo.Events E with (nolock)
JOIN dbo.Tickets T  (NOLOCK) ON E.EventId = T.EventId
 Join dbo.EventUsers U on T.UserId = u.UserId
   Join dbo.Sponsors s on E.EventId = s.EventId
GO
/****** Object:  Table [dbo].[Complaints]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Complaints](
	[ComplaintId] [int] IDENTITY(1,1) NOT NULL,
	[complaintDescription] [xml] NULL,
	[UserID] [int] NOT NULL,
	[Created_Timestamp] [datetime] NULL,
	[Created_By] [varchar](255) NULL,
	[Modified_Timestamp] [datetime] NULL,
	[Modified_By] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ComplaintId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[ErrorId] [int] IDENTITY(1,1) NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets_History]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets_History](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[TicketType] [varchar](255) NULL,
	[TicketCount] [numeric](18, 0) NOT NULL,
	[TicketPrice] [int] NOT NULL,
	[TicketAmount] [decimal](18, 2) NOT NULL,
	[Created_Timestamp] [datetime] NULL,
	[Modified_Timestamp] [datetime] NULL,
	[Created_By] [varchar](255) NULL,
	[Modified_By] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaints_UserId] FOREIGN KEY([UserID])
REFERENCES [dbo].[EventUsers] ([UserId])
GO
ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaints_UserId]
GO
ALTER TABLE [dbo].[Sponsors]  WITH CHECK ADD  CONSTRAINT [FK_Sponsors_EventId] FOREIGN KEY([EventID])
REFERENCES [dbo].[Events] ([EventId])
GO
ALTER TABLE [dbo].[Sponsors] CHECK CONSTRAINT [FK_Sponsors_EventId]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_EventId] FOREIGN KEY([EventId])
REFERENCES [dbo].[Events] ([EventId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_EventId]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[EventUsers] ([UserId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_UserId]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [CHK_EventDate] CHECK  (([EventTime]>getdate()))
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [CHK_EventDate]
GO
ALTER TABLE [dbo].[Sponsors]  WITH CHECK ADD  CONSTRAINT [CHK_Amount_Sponspor] CHECK  (([Price]>(1000)))
GO
ALTER TABLE [dbo].[Sponsors] CHECK CONSTRAINT [CHK_Amount_Sponspor]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [CHK_Amount] CHECK  (([TicketPrice]>(0)))
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [CHK_Amount]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [CHK_TicketCount] CHECK  (([TicketCount]>(0)))
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [CHK_TicketCount]
GO
/****** Object:  StoredProcedure [dbo].[AbovethreetimesEventusers]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[AbovethreetimesEventusers]
AS
BEGIN 
     SET NOCOUNT ON 
    select * from  Abovethreetimesusers
END 

GO
/****** Object:  StoredProcedure [dbo].[AllEventManagementReport]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AllEventManagementReport] AS
SELECT E.EventName,E.EventLocation,T.TicketPrice,T.TicketAmount,U.username,U.Age,s.SponsorName
FROM  dbo.Events E with (nolock)
left JOIN dbo.Tickets T  (NOLOCK) ON E.EventId = T.EventId
left Join dbo.EventUsers U on T.UserId = u.UserId
left   Join dbo.Sponsors s on E.EventId = s.EventId


GO
/****** Object:  StoredProcedure [dbo].[AllSponsorNamesForEvents]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[AllSponsorNamesForEvents] AS
SELECT E.EventName,E.EventLocation,s.SponsorName,s.Price
FROM  dbo.Events E with (nolock)
left   Join dbo.Sponsors s on E.EventId = s.EventId

GO
/****** Object:  StoredProcedure [dbo].[CancelTicket]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[CancelTicket]
@TicketID int
AS
BEGIN 
     SET NOCOUNT ON 
DEclare @checkDate Datetime
DEclare @EventDate Datetime
Declare @verifydate int
SET @EventDate = (select EventTime from events where eventid = (select eventid from tickets where ticketid =@TicketID))
print @EventDate
print @verifydate
SET @verifydate = (SELECT DATEDIFF(Day,@EventDate,GetDate()) )
print @verifydate
if(@verifydate >= 2)
BEGIN
print @verifydate
     Delete from  Tickets 
        where TicketID =  @TicketID
END
ELSE
BEGIN
Insert into ErrorLog (ErrorMessage, CreatedDate) values ('cannot delete tickets',GETDATE())
END 
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteComplaint]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[DeleteComplaint]
@ComplaintId int
AS
BEGIN 
     SET NOCOUNT ON 
     Delete from  Complaints 
         where ComplaintId =  @ComplaintId
END 
GO
/****** Object:  StoredProcedure [dbo].[DeleteEvent]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[DeleteEvent]
@EventId int
AS
BEGIN 
     SET NOCOUNT ON 

     Delete from  Events 
         where EventId =  @EventId
END 
GO
/****** Object:  StoredProcedure [dbo].[DeleteTickets]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTickets]
@TicketID int
AS
BEGIN 
     SET NOCOUNT ON 
DEclare @checkDate Datetime
DEclare @EventDate Datetime
Declare @verifydate Datetime
SET @checkDate= getdate()
SET @EventDate = (select EventTime from events where eventid = (select eventid from tickets where ticketid =@TicketID))
SET @verifydate = (SELECT DATEDIFF(Day,@checkDate,@EventDate) )
if(@verifydate > 1)
     Delete from  Tickets 
         where TicketID =  @TicketID
		
		 

END 
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[DeleteUser]
@UserId int
AS
BEGIN 
     SET NOCOUNT ON 

     Delete from  EventUsers 
         where UserId =  @UserId
END 
GO
/****** Object:  StoredProcedure [dbo].[EventName_Number_of_tickets]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[EventName_Number_of_tickets]
AS
BEGIN 
DECLARE @i int = 1
declare @eventcount int =0
declare @tablecount int =0
declare @eventname varchar(255)
declare @ticketcount numeric
SET NOCOUNT ON 
SET  @eventcount= (select count(Eventid) from events)
declare @VariableTableCustomer table
    ( 
      [Eventname] varchar(255)
    , [TicketCount] numeric (18,0)
    )
print @i
print @eventcount
Set @tablecount = (select top 1 eventid from events order by 1 asc)
print @tablecount
WHILE @i < 20
BEGIN

SET @eventname = (select eventname from events where  eventid =@tablecount)
print @eventname 
SET @ticketcount =  (select sum(ticketcount) from tickets where  eventid =@tablecount)
print @ticketcount
INSERT INTO @VariableTableCustomer ( [Eventname] , [TicketCount])
values(@eventname,@ticketcount)
SET @tablecount=  @tablecount + 1
SET @i = @i +1
END
select distinct [Eventname] ,[TicketCount] from @VariableTableCustomer where eventname is not null
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllComplaints]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[GetAllComplaints]ASBEGIN SELECT u.username,u.UserEmailAddress,u.UserMobileNumber, c.complaintDescription.value('(/Complaint/ComplaintDescription)[1]', 'nvarchar(max)') as complaintDescription,  c.complaintDescription.value('(/Complaint/PPSNumber)[1]', 'nvarchar(max)') as PPSNumber,    c.complaintDescription.value('(/Complaint/Address)[1]', 'nvarchar(max)') as UserAddressFROM  dbo.EventUsers U with (nolock) inner join dbo.complaints c on c.userid = u.userid END
GO
/****** Object:  StoredProcedure [dbo].[Insertcomplaints]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Insertcomplaints]@complaintDescription xml ,@UserID varchar(max),@Created_Timestamp datetime,@Created_By varchar(255)ASBEGIN      SET NOCOUNT ON   INSERT INTO [dbo].[Complaints]           ([complaintDescription]           ,[UserID]           ,[Created_Timestamp]           ,[Created_By]           )     VALUES          (@complaintDescription,		  @UserID,		  @Created_Timestamp,		 @Created_By  )           END 
GO
/****** Object:  StoredProcedure [dbo].[InsertEvents]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertEvents]
@EventName varchar(255) ,
@EventDescription varchar(max),
@EventTime datetime ,
@EventLocation varchar(255),
@EventPolicy varchar(255) ,
@EventCapacity int ,
@Created_Timestamp datetime,
@Created_By varchar(255)
AS
BEGIN 
     SET NOCOUNT ON 

    INSERT INTO dbo.Events
               (    
    [EventName],
	[EventDescription],
	[EventTime] ,
	[EventLocation],
	[EventPolicy],
	[EventCapacity],
	[Created_Timestamp] ,
	[Created_By] 
      )  VALUES   ( 
          @EventName ,
	@EventDescription ,
	@EventTime  ,
	@EventLocation,
	@EventPolicy ,
	@EventCapacity,
	@Created_Timestamp ,
	@Created_By 
          ) 
END 
GO
/****** Object:  StoredProcedure [dbo].[InsertSponsor]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[InsertSponsor]
@EventID Int,
@SponsorName varchar(255), 
@SponsorDescription varchar(max) ,
@Price numeric  (18,0),
@Created_Timestamp [datetime] ,
@Created_By varchar(255)
	
AS
BEGIN 
   

     INSERT INTO dbo.Sponsors
          (                    
    [EventID] ,
	[SponsorName] ,
	[Sponsor Description] ,
	
	
	[Price] ,
	[Created_Timestamp] ,
	
	[Created_By] 
	
          ) 
     VALUES 
          ( 
          @EventID,
	@SponsorName ,
	@SponsorDescription  ,
	

	@Price,
	@Created_Timestamp ,

	@Created_By 
	
          ) 

END 
GO
/****** Object:  StoredProcedure [dbo].[Inserttickets]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inserttickets] @EventId           INT, 
                                       @UserId            INT, 
                                       @TicketType        VARCHAR(255), 
                                       @TicketCount       NUMERIC, 
                                       @TicketPrice       DECIMAL (18, 2), 
                                       @Created_By        VARCHAR(255) 
AS 
  BEGIN 
      SET nocount ON 

      DECLARE @Useridcount INT 
      DECLARE @Agecount INT 
      DECLARE @TicketAmount DECIMAL (18, 2) 

      SET @TicketAmount = @TicketPrice * @TicketCount 
      SET @Agecount = 0 
      SET @Useridcount =0 
      SET @Useridcount= (SELECT Count(userid) 
                         FROM   tickets 
                         WHERE  userid = @userid) 
      SET @Agecount = (SELECT TOP 1 age 
                       FROM   eventusers 
                       WHERE  userid = @userid) 

      IF ( @Useridcount >= 3 ) 
        SET @TicketAmount = 0.80 * @TicketPrice * @TicketCount 

      IF ( @Agecount <= 16 
           AND @Useridcount < 3 ) 
        SET @TicketAmount = 0.90 * @TicketPrice * @TicketCount 

      INSERT INTO dbo.tickets 
                  ([tickettype], 
                   [ticketcount], 
                   [ticketprice], 
                   [ticketamount], 
                   [eventid], 
                   [userid], 
                   [created_timestamp], 
                   [created_by]) 
      VALUES      ( @TicketType, 
                    @TicketCount, 
                    @TicketPrice, 
                    @TicketAmount, 
                    @EventId, 
                    @UserId, 
                    GETDATE(), 
                    @Created_By ) 
  END 

GO
/****** Object:  StoredProcedure [dbo].[Insertuser]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertuser] @UserName          VARCHAR(255), 
                                    @UserEmailAddress  VARCHAR(255), 
                                    @UserMobileNumber  VARCHAR(255), 
                                    @Age               NUMERIC, 
                                    @Created_Timestamp DATETIME, 
                                    @Created_By        VARCHAR(255) 
AS 
  BEGIN 
      INSERT INTO dbo.eventusers 
                  ([username], 
                   [useremailaddress], 
                   [usermobilenumber], 
                   [age], 
                   [created_timestamp], 
                   [created_by]) 
      VALUES      ( @UserName, 
                    @UserEmailAddress, 
                    @UserMobileNumber, 
                    @Age, 
                    @Created_Timestamp, 
                    @Created_By ) 
  END 

GO
/****** Object:  StoredProcedure [dbo].[MontlyEventManagementreport]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[MontlyEventManagementreport]
AS
BEGIN 
SELECT  E.EventName,E.EventLocation,T.TicketPrice,T.TicketAmount,U.username,U.Age,
c.complaintdescription
FROM  dbo.Events E with (nolock)
inner JOIN dbo.Tickets T  (NOLOCK) ON E.EventId = T.EventId
 inner Join dbo.EventUsers U on T.UserId = u.UserId
 inner join dbo.complaints c on c.userid = u.userid 
 where eventtime > = (DATEADD(day, -30, getdate()))
END
GO
/****** Object:  StoredProcedure [dbo].[SearchComplaint]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchComplaint]@searchstring varchar(max)ASBEGIN      SET NOCOUNT ON     select  complaintDescriptionfrom  Complaintswhere  complaintDescription.value('(/Complaint/ComplaintDescription)[1]', 'varchar(max)') like '%'+@searchstring+'%'END
GO
/****** Object:  StoredProcedure [dbo].[TotalAmount]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TotalAmount]
AS
BEGIN 
     SET NOCOUNT ON 
    select sum(TicketAmount)as ticketamount from tickets
END 

GO
/****** Object:  StoredProcedure [dbo].[UpdateComplaints]    Script Date: 4/24/2019 12:02:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[UpdateComplaints]@ComplaintId int,@complaintDescription xml ,@Modified_Timestamp datetime,@Modified_By varchar(255)ASBEGIN      SET NOCOUNT ON Update [dbo].[Complaints]SET [complaintDescription] = @complaintDescription,Modified_Timestamp =@Modified_Timestamp,Modified_By = @Modified_Bywhere ComplaintId = @ComplaintIdEND 
GO
USE [master]
GO
ALTER DATABASE [EventManagementSystem] SET  READ_WRITE 
GO
