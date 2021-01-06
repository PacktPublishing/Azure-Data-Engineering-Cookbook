
-- Create table to store file copy status
DROP TABLE IF EXISTS FileCopyStatus
CREATE TABLE FileCopyStatus(
Id int identity,
filename varchar(500),
fromdirectory varchar(100),
todirectory varchar(100),
Createdate datetime Default(Getdate())
);
GO
CREATE OR ALTER PROC usp_UpdateCopyStatus
@filename varchar(500),
@fromdirectory varchar(100),
@todirectory varchar(100)
AS
BEGIN

SET NOCOUNT ON

INSERT INTO FileCopyStatus (
	[filename],
	[fromdirectory],
	[todirectory]
)
VALUES(@filename,@fromdirectory,@todirectory)

END


-- Create TABLE to store pipeline configuration
DROP TABLE IF exists PipelineConfiguration
GO
CREATE TABLE PipelineConfiguration ([key] VARCHAR(100),[value] VARCHAR(100))
GO
INSERT INTO PipelineConfiguration VALUES('Pipeline-Controlflow-Activities','true')
GO
CREATE PROC usp_GetPipelineStatus
@key VARCHAR(100)
AS
SELECT [Value] FROM PipelineConfiguration WHERE [key]=@key

