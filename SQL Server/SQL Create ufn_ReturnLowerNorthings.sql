/*===========================================================================*\
  DataExtractor is a MapInfo tool to extract biodiversity information
  from SQL Server and MapInfo GIS layer for pre-defined spatial areas.
  
  Copyright © 2012 Andy Foy Consulting
  
  This file is part of the MapInfo tool 'DataExtractor'.
  
  DataExtractor is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  DataExtractor is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with DataExtractor.  If not, see <http://www.gnu.org/licenses/>.
\*===========================================================================*/

USE [NBNData]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*===========================================================================*\
  Description:	Returns the northings value for the lower left bounding box
                of an northings value at the required precision.

  Parameters:
	@Northings		The current northings value.
	@Precision		The precision of the bounding box required.

  Created:	Nov 2012

  Last revision information:
    $Revision: 1 $
    $Date: 10/12/12 12:19 $
    $Author: Andy Foy $

\*===========================================================================*/

-- Drop the user function if it already exists
if exists (select ROUTINE_NAME from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'ufn_ReturnLowerNorthings')
	DROP FUNCTION dbo.ufn_ReturnLowerNorthings
GO

-- Create the user function
CREATE FUNCTION dbo.ufn_ReturnLowerNorthings(@Northings Int, @Precision Int)
RETURNS VarChar(6)

AS
BEGIN
	
	Declare @ReturnValue Int
	SET @ReturnValue = 
	CASE
		WHEN @Northings <> 0 AND @Precision = 1			THEN (@Northings/@Precision) * @Precision
		WHEN @Northings <> 0 AND @Precision = 10		THEN (@Northings/@Precision) * @Precision
		WHEN @Northings <> 0 AND @Precision = 100		THEN (@Northings/@Precision) * @Precision
		WHEN @Northings <> 0 AND @Precision = 1000		THEN (@Northings/@Precision) * @Precision
		WHEN @Northings <> 0 AND @Precision = 2000		THEN (@Northings/@Precision) * @Precision
		WHEN @Northings <> 0 AND @Precision = 10000		THEN (@Northings/@Precision) * @Precision
		WHEN @Northings <> 0 AND @Precision = 100000	THEN (@Northings/@Precision) * @Precision
		ELSE @Northings
	END
     
	RETURN @ReturnValue

END