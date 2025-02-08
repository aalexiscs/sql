DECLARE @counter INT = 1; -- Variable to control the loop

WHILE @counter <> 0
BEGIN
    BEGIN TRANSACTION; -- Start a transaction

    DELETE TOP (5000) -- delete up to 5000 records per batch
    FROM dbo.table_name

    SET @counter = @@ROWCOUNT; -- Updates the @counter variable with the number of rows affected by the DELETE
                               -- if no more rows are deleted (0 records), the loop will exit
    
    COMMIT TRANSACTION; -- confirms the transaction for each block

    WAITFOR DELAY '00:00:10'; -- introduces a 10 second pause between each block to allow time for other queries to access the table 
END