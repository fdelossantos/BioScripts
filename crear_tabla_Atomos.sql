USE [Molecula]
GO

/****** Object:  Table [dbo].[Atomos]    Script Date: 6/7/2024 0:58:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Atomos](
	[RecordName] [varchar](6) NOT NULL,
	[Serial] [int] NOT NULL,
	[Name] [varchar](4) NOT NULL,
	[altLoc] [char](1) NOT NULL,
	[resName] [varchar](4) NOT NULL,
	[ChainID] [char](1) NOT NULL,
	[ResSeq] [int] NULL,
	[iCode] [char](1) NULL,
	[CoordX] [decimal](7, 3) NOT NULL,
	[CoordY] [decimal](7, 3) NOT NULL,
	[CoordZ] [decimal](7, 3) NOT NULL,
	[Occupancy] [decimal](7, 3) NOT NULL,
	[TempFactor] [decimal](7, 3) NULL,
	[Element] [varchar](2) NULL,
	[Charge] [varchar](2) NULL,
 CONSTRAINT [PK_Atomos] PRIMARY KEY CLUSTERED 
(
	[Serial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


