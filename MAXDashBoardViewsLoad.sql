USE [COMDEL]
GO

/****** Object:  View [dbo].[InventoryValueBase]    Script Date: 11/11/2010 14:22:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[InventoryValueBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [InventoryValueBase] END
GO

CREATE VIEW [dbo].[InventoryValueBase]
AS
SELECT     dbo.Part_Stock.STK_06, dbo.Part_Master.PRTNUM_01, dbo.Part_Master.PMDES1_01, dbo.Part_Master.COST_01, dbo.Part_Master.CSTUOM_01, 
                      dbo.Part_Master.CSTCNV_01, dbo.Part_Stock.QTYOH_06, 
                      dbo.Part_Stock.QTYOH_06 * dbo.Part_Master.COST_01 / dbo.Part_Master.CSTCNV_01 AS Value
FROM         dbo.Part_Master INNER JOIN
                      dbo.Part_Stock ON dbo.Part_Master.PRTNUM_01 = dbo.Part_Stock.PRTNUM_06

GO


/****** Object:  View [dbo].[MAXBookingDetails]    Script Date: 11/11/2010 14:21:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXBookingDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXBookingDetails] END
GO

/****** Object:  View [dbo].[MAXBookingDetails]    Script Date: 02/11/2009 09:58:41 ******/
CREATE VIEW [dbo].[MAXBookingDetails]
AS
SELECT     CONVERT(char(7), dbo.SO_Master.ORDDTE_27, 20) AS OrdMonth, CONVERT(char(7), dbo.SO_Detail.SHPDTE_28, 20) AS ShipMonth, 
                      dbo.SO_Master.NAME_27 AS CusNam, dbo.SO_Detail.ORDNUM_28 + '-' + dbo.SO_Detail.LINNUM_28 + '-' + dbo.SO_Detail.DELNUM_28 AS SONum, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * CURQTY_28 ELSE CURQTY_28 END AS Qty, dbo.SO_Detail.DUEQTY_28 AS DueQty, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * SHPQTY_28 ELSE SHPQTY_28 END AS ShpQty, dbo.SO_Detail.PRTNUM_28 AS PrtNum, 
                      dbo.Part_Sales.PMDES1_29 AS PrtDes, dbo.SO_Master.ORDDTE_27 AS OrdDte, dbo.SO_Detail.UDFKEY_28 AS RelDte, 
                      dbo.SO_Detail.REFRNC_28 AS Ref, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * dbo.SO_Detail.CURQTY_28 * dbo.SO_Detail.PRICE_28 ELSE dbo.SO_Detail.CURQTY_28 * dbo.SO_Detail.PRICE_28
                       END AS Value, CASE WHEN SType_28 = 'CR' THEN - 1 * dbo.SO_Detail.CURQTY_28 * (dbo.SO_Detail.PRICE_28 - COST_28) 
                      ELSE dbo.SO_Detail.CURQTY_28 * (dbo.SO_Detail.PRICE_28 - COST_28) END AS GrossMargin, dbo.SO_Detail.SHPDTE_28 AS ShpDte, 
                      dbo.SO_Detail.UDFREF_28 AS SN, dbo.SO_Detail.CURDUE_28 AS CurDue, dbo.SO_Detail.CUSDUE_28 AS CusDue, 
                      dbo.SO_Detail.STATUS_28 AS Status, dbo.SO_Detail.PRICE_28 AS Price, dbo.SO_Detail.COST_28 AS Cost, dbo.SO_Detail.DISC_28 AS Disc, 
                      dbo.Part_Sales.XDFFLT_29 AS XDFFLT, dbo.Part_Sales.XDFBOL_29 AS XDFBOL, dbo.SO_Detail.XDFTXT_28 AS XDFTXT, 
                      dbo.Part_Sales.PRDLIN_29 AS PrdLin, dbo.SO_Master.REP1_27 AS SlsRep, dbo.SO_Detail.ORDNUM_28 AS OrdNum, 
                      dbo.SO_Detail.LINNUM_28 AS LinNum, dbo.SO_Master.GLXREF_27 AS GLXRef, dbo.SO_Detail.STYPE_28 AS OrdTyp, 
                      dbo.Sales_Rep_Master.SLSTER_26 AS Territory, dbo.SO_Master.CUSTID_27 AS CustID, dbo.Sales_Rep_Master.YQSLS_26
FROM         dbo.Part_Sales INNER JOIN
                      dbo.SO_Master INNER JOIN
                      dbo.SO_Detail ON dbo.SO_Master.ORDNUM_27 = dbo.SO_Detail.ORDNUM_28 ON 
                      dbo.Part_Sales.PRTNUM_29 = dbo.SO_Detail.PRTNUM_28 LEFT OUTER JOIN
                      dbo.Sales_Rep_Master ON dbo.SO_Master.REP1_27 = dbo.Sales_Rep_Master.SLSREP_26
WHERE     (dbo.SO_Detail.STYPE_28 <> 'QT')

GO



/****** Object:  View [dbo].[MAXBookingsDetailsGrossMargin]    Script Date: 11/11/2010 14:22:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXBookingsDetailsGrossMargin]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXBookingsDetailsGrossMargin] END
GO


CREATE VIEW [dbo].[MAXBookingsDetailsGrossMargin]
AS
SELECT     CONVERT(char(7), dbo.SO_Master.ORDDTE_27, 20) AS OrdMonth, CONVERT(char(7), dbo.SO_Detail.SHPDTE_28, 20) AS ShipMonth, 
                      dbo.SO_Master.NAME_27 AS CusNam, dbo.SO_Detail.ORDNUM_28 + '-' + dbo.SO_Detail.LINNUM_28 + '-' + dbo.SO_Detail.DELNUM_28 AS SONum, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * CURQTY_28 ELSE CURQTY_28 END AS Qty, dbo.SO_Detail.DUEQTY_28 AS DueQty, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * SHPQTY_28 ELSE SHPQTY_28 END AS ShpQty, dbo.SO_Detail.PRTNUM_28 AS PrtNum, 
                      dbo.Part_Sales.PMDES1_29 AS PrtDes, dbo.SO_Master.ORDDTE_27 AS OrdDte, dbo.SO_Detail.UDFKEY_28 AS RelDte, 
                      dbo.SO_Detail.REFRNC_28 AS Ref, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * dbo.SO_Detail.CURQTY_28 * dbo.SO_Detail.PRICE_28 ELSE dbo.SO_Detail.CURQTY_28 * dbo.SO_Detail.PRICE_28
                       END AS Value, CASE WHEN SType_28 = 'CR' THEN - 1 * dbo.SO_Detail.CURQTY_28 * (dbo.SO_Detail.PRICE_28 - COST_28) 
                      ELSE dbo.SO_Detail.CURQTY_28 * (dbo.SO_Detail.PRICE_28 - COST_28) END AS GrossMargin, dbo.SO_Detail.SHPDTE_28 AS ShpDte, 
                      dbo.SO_Detail.UDFREF_28 AS SN, dbo.SO_Detail.CURDUE_28 AS CurDue, dbo.SO_Detail.CUSDUE_28 AS CusDue, 
                      dbo.SO_Detail.STATUS_28 AS Status, dbo.SO_Detail.PRICE_28 AS Price, dbo.SO_Detail.COST_28 AS Cost, dbo.SO_Detail.DISC_28 AS Disc, 
                      dbo.Part_Sales.XDFFLT_29 AS XDFFLT, dbo.Part_Sales.XDFBOL_29 AS XDFBOL, dbo.SO_Detail.XDFTXT_28 AS XDFTXT, 
                      dbo.Part_Sales.PRDLIN_29 AS PrdLin, dbo.SO_Master.REP1_27 AS SlsRep, dbo.SO_Detail.ORDNUM_28 AS OrdNum, 
                      dbo.SO_Detail.LINNUM_28 AS LinNum, dbo.SO_Master.GLXREF_27 AS GLXRef, dbo.SO_Detail.STYPE_28 AS OrdTyp, 
                      dbo.Sales_Rep_Master.SLSTER_26 AS Territory, dbo.SO_Master.CUSTID_27 AS CustID
FROM         dbo.Part_Sales INNER JOIN
                      dbo.SO_Master INNER JOIN
                      dbo.SO_Detail ON dbo.SO_Master.ORDNUM_27 = dbo.SO_Detail.ORDNUM_28 ON 
                      dbo.Part_Sales.PRTNUM_29 = dbo.SO_Detail.PRTNUM_28 LEFT OUTER JOIN
                      dbo.Sales_Rep_Master ON dbo.SO_Master.REP1_27 = dbo.Sales_Rep_Master.SLSREP_26
WHERE     (dbo.SO_Detail.STYPE_28 <> 'QT')

GO



/****** Object:  View [dbo].[MAXCycleCountDetails]    Script Date: 11/11/2010 14:49:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXCycleCountDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXCycleCountDetails] END
GO

CREATE VIEW [dbo].[MAXCycleCountDetails]
AS
SELECT     YEAR(dbo.Transaction_History.TNXDTE_15) AS Year, CASE WHEN MONTH(dbo.Transaction_History.TNXDTE_15) 
                      = 1 THEN 'Jan' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) = 2 THEN 'Feb' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) 
                      = 3 THEN 'Mar' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) = 4 THEN 'Apr' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) 
                      = 5 THEN 'May' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) = 6 THEN 'Jun' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) 
                      = 7 THEN 'Jul' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) = 8 THEN 'Aug' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) 
                      = 9 THEN 'Sep' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) = 10 THEN 'Oct' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) 
                      = 11 THEN 'Nov' WHEN MONTH(dbo.Transaction_History.TNXDTE_15) = 12 THEN 'Dec' END AS Month, ROUND(dbo.Transaction_History.COST_15, 2) 
                      AS DeltaValuePerUnit, dbo.Transaction_History.COST_15 * dbo.Transaction_History.DELTA_15 AS DeltaValueTotal, 
                      ROUND(dbo.Transaction_History.TNXQTY_15 * dbo.Transaction_History.COST_15, 2) AS EndValue, 
                      dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15 AS StartQty, 
                      CASE WHEN ABS(dbo.Transaction_History.COST_15 * dbo.Transaction_History.DELTA_15) > CYCDOL_01 THEN 0 ELSE 1 END AS OOTCheckValue, 
                      CASE WHEN (dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) 
                      = 0 THEN 1 WHEN ABS(TNXQTY_15 / ((dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) * 100)) 
                      > CYCPER_01 THEN 0 ELSE 1 END AS OOTCheckPrcnt, 
                      CASE WHEN (CASE WHEN ABS(dbo.Transaction_History.COST_15 * dbo.Transaction_History.DELTA_15) > CYCDOL_01 THEN 0 ELSE 1 END) 
                      + (CASE WHEN (dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) 
                      = 0 THEN 1 WHEN ABS(TNXQTY_15 / ((dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) * 100)) 
                      > CYCPER_01 THEN 0 ELSE 1 END) = 2 THEN 1 ELSE 0 END AS OOTSum, 
                      ROUND(CASE WHEN (dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) 
                      = 0 THEN 0 ELSE ABS(dbo.Transaction_History.DELTA_15 / ((dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) * 100)) END, 
                      1) AS PrcntChange, (dbo.Transaction_History.TNXQTY_15 - dbo.Transaction_History.DELTA_15) * dbo.Transaction_History.COST_15 AS StartValue, 
                      CONVERT(varchar(20), dbo.Transaction_History.TNXDTE_15, 1) AS TNX_DATE, dbo.Transaction_History.STKID_15, 
                      RTRIM(dbo.Part_Master.PRTNUM_01) AS PartID, RTRIM(dbo.Part_Master.PMDES1_01) AS PartDesc, dbo.Transaction_History.TNXCDE_15, 
                      dbo.Part_Master.CLSCDE_01, dbo.Part_Master.PLANID_01, dbo.Part_Master.COMCDE_01, dbo.Part_Master.PMDES2_01, 
                      dbo.Part_Master.BOMUOM_01, dbo.Part_Master.TYPE_01, dbo.Part_Master.COST_01, dbo.Part_Master.BUYER_01, dbo.Part_Master.ACTTYP_01, 
                      dbo.Part_Master.REVLEV_01, dbo.Transaction_History.TNXQTY_15 AS EndQty, dbo.Transaction_History.REFDES_15, 
                      dbo.Transaction_History.TNXDTE_15
FROM         dbo.Transaction_History INNER JOIN
                      dbo.Part_Master ON dbo.Transaction_History.PRTNUM_15 = dbo.Part_Master.PRTNUM_01
WHERE     (dbo.Transaction_History.TNXCDE_15 = 'C')

GO



/****** Object:  View [dbo].[MAXInvCCTnxCount]    Script Date: 11/11/2010 14:48:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXInvCCTnxCount]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXInvCCTnxCount] END
GO

CREATE VIEW [dbo].[MAXInvCCTnxCount]
AS
SELECT     TOP (100) PERCENT COUNT(*) AS TnxCnt, DATEPART(mm, TNXDTE_15) AS MthNum, DATENAME(Month, TNXDTE_15) AS Mth
FROM         dbo.Transaction_History
WHERE     (TNXDTE_15 >= DATEADD(m, - 6, GETDATE())) AND (TNXCDE_15 = 'A' OR
                      TNXCDE_15 = 'C')
GROUP BY DATEPART(mm, TNXDTE_15), DATENAME(Month, TNXDTE_15)
ORDER BY MthNum

GO


/****** Object:  View [dbo].[MAXInvCCTnxDeltaCount]    Script Date: 11/11/2010 14:49:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXInvCCTnxDeltaCount]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXInvCCTnxDeltaCount] END
GO

CREATE VIEW [dbo].[MAXInvCCTnxDeltaCount]
AS
SELECT     TOP (100) PERCENT COUNT(*) AS DCnt, DATEPART(mm, TNXDTE_15) AS MthNum, DATENAME(Month, TNXDTE_15) AS Mth
FROM         dbo.Transaction_History
WHERE     (DELTA_15 <> 0) AND (TNXDTE_15 >= DATEADD(m, - 6, GETDATE())) AND (TNXCDE_15 = 'A' OR
                      TNXCDE_15 = 'C')
GROUP BY DATEPART(mm, TNXDTE_15), DATENAME(Month, TNXDTE_15)
ORDER BY MthNum

GO


/****** Object:  View [dbo].[MAXInvCycleCountBase]    Script Date: 11/11/2010 14:49:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXInvCycleCountBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXInvCycleCountBase] END
GO

CREATE VIEW [dbo].[MAXInvCycleCountBase]
AS
SELECT     dbo.MAXInvCCTnxCount.TnxCnt, dbo.MAXInvCCTnxDeltaCount.DCnt, (CAST(dbo.MAXInvCCTnxCount.TnxCnt AS FLOAT) 
                      - CAST(dbo.MAXInvCCTnxDeltaCount.DCnt AS FLOAT)) / CAST(dbo.MAXInvCCTnxCount.TnxCnt AS FLOAT) AS Accu, dbo.MAXInvCCTnxCount.MthNum, 
                      dbo.MAXInvCCTnxCount.Mth
FROM         dbo.MAXInvCCTnxCount INNER JOIN
                      dbo.MAXInvCCTnxDeltaCount ON dbo.MAXInvCCTnxCount.MthNum = dbo.MAXInvCCTnxDeltaCount.MthNum

GO


/****** Object:  View [dbo].[MAXJobProgress]    Script Date: 11/11/2010 14:55:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXJobProgress]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXJobProgress] END
GO

CREATE VIEW [dbo].[MAXJobProgress]
AS
SELECT     TOP (100) PERCENT dbo.Order_Master.ORDNUM_10 AS [ORDER], dbo.Job_Progress.OPRSEQ_14 AS OPR_SEQ, 
                      RTRIM(dbo.Job_Progress.PRTNUM_14) AS PART_NUMBER, RTRIM(dbo.Part_Master.PMDES1_01) AS PART_DESC, 
                      dbo.Job_Progress.WRKCTR_14 AS WORK_CNTR, dbo.SFC_Work_Center.DESC_13 AS WORK_CNTR_DESC, 
                      dbo.Job_Progress.OPRDES_14 AS OPR_DESC, 
                      dbo.Job_Progress.RUNTIM_14 * dbo.Order_Master.CURQTY_10 / dbo.Job_Progress.QTYPER_14 AS RUN_TIME_STD, 
                      dbo.Job_Progress.RUNACT_14 AS RUN_TIME_ACTUAL, dbo.Job_Progress.SETTIM_14 AS SET_UP_TIME_STD, 
                      dbo.Job_Progress.SETACT_14 AS SET_UP_TIME_ACTUAL, dbo.Job_Progress.QTYCOM_14 AS QTY_COMPLETE, 
                      dbo.Job_Progress.QTYREM_14 AS QTY_REMAINING, ROUND(dbo.Job_Progress.QTYCOM_14 / (1 - dbo.Job_Progress.PSCRAP_14 / 100) 
                      * dbo.Job_Progress.PSCRAP_14 / 100, 0) AS SCRAP_PLANNED, dbo.Job_Progress.ASCRAP_14 AS SCRAP_ACTUAL, 
                      CASE WHEN STATUS_10 = '3' THEN 'OPEN' WHEN STATUS_10 = '4' THEN 'COMPLETE' WHEN STATUS_10 = '5' THEN 'CLOSED' END AS ORDER_STATUS,
                       CASE WHEN OPRTYP_14 = 'U' THEN 'UNIT' WHEN OPRTYP_14 = 'B' THEN 'BATCH' WHEN OPRTYP_14 = 'P' THEN 'PART IDENTIFIER' WHEN OPRTYP_14
                       = 'C' THEN 'COMMENT' WHEN OPRTYP_14 = 'V' THEN 'VARIABLE' END AS OPR_TYPE, 
                      CASE WHEN QUECDE_14 = 'Y' THEN 'STAGED' WHEN QUECDE_14 = 'N' THEN 'NOT STAGED' WHEN QUECDE_14 = 'C' THEN 'COMPLETED' END AS QUEUE_DESC,
                       dbo.Job_Progress.QUECDE_14 AS QUEUE_CODE, dbo.Job_Progress.TOOL_14 AS TOOL, dbo.Job_Progress.QTYPER_14 AS QTY_PER, 
                      dbo.Job_Progress.UDFKEY_14 AS UDFKEY, dbo.Job_Progress.UDFREF_14 AS UDFREF, dbo.Order_Master.CURQTY_10, 
                      dbo.Order_Master.ORDREF_10 AS REFERENCE, dbo.SFC_Work_Center.HRSMAN_13 * (dbo.SFC_Work_Center.WRKUTL_13 / 100) AS CapacityHrs, 
                      dbo.SFC_Work_Center.TOTINP_13, dbo.SFC_Work_Center.HRSMAN_13, dbo.SFC_Work_Center.TOTLOD_13, dbo.SFC_Work_Center.TOTQUE_13, 
                      dbo.SFC_Work_Center.WRKUTL_13, dbo.SFC_Work_Center.SETINC_13, dbo.SFC_Work_Center.STDQUE_13, dbo.Order_Master.CURDUE_10, 
                      dbo.Job_Progress.RUNTIM_14
FROM         dbo.Job_Progress INNER JOIN
                      dbo.Part_Master ON dbo.Job_Progress.PRTNUM_14 = dbo.Part_Master.PRTNUM_01 INNER JOIN
                      dbo.Order_Master ON dbo.Job_Progress.ORDNUM_14 = dbo.Order_Master.ORDER_10 INNER JOIN
                      dbo.SFC_Work_Center ON dbo.Job_Progress.WRKCTR_14 = dbo.SFC_Work_Center.WRKCTR_13
ORDER BY [ORDER]

GO



/****** Object:  View [dbo].[MAXLateShopOrderSummary]    Script Date: 11/11/2010 14:55:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXLateShopOrderSummary]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXLateShopOrderSummary] END
GO

CREATE VIEW [dbo].[MAXLateShopOrderSummary]
AS
SELECT     TOP (100) PERCENT COUNT(ORDNUM_10) AS OrdCnt, SUM(COST_10 * CURQTY_10) AS OrdCst
FROM         dbo.Order_Master
WHERE     (TYPE_10 = 'MF') OR
                      (TYPE_10 = 'MS') AND (CURDUE_10 < GETDATE()) AND (STATUS_10 = '3')

GO


/****** Object:  View [dbo].[MAXMonthlyPOReceiptCommittments]    Script Date: 11/11/2010 14:23:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXMonthlyPOReceiptCommittments]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXMonthlyPOReceiptCommittments] END
GO

CREATE VIEW [dbo].[MAXMonthlyPOReceiptCommittments]
AS
SELECT     dbo.Order_Master.ORDNUM_10, dbo.Order_Master.LINNUM_10, dbo.Order_Master.DELNUM_10, dbo.Order_Master.PRTNUM_10, 
                      dbo.Part_Master.PMDES1_01, dbo.Order_Master.DUEQTY_10, dbo.Part_Master.PURUOM_01, dbo.Part_Master.COST_01, 
                      dbo.Order_Master.DUEQTY_10 * dbo.Part_Master.COST_01 / dbo.Part_Master.PURCNV_01 AS Value, dbo.Part_Master.PURCNV_01, CONVERT(char(7), 
                      dbo.Order_Master.CURDUE_10, 20) AS DueMonth, dbo.Order_Master.CURDUE_10
FROM         dbo.Order_Master INNER JOIN
                      dbo.Part_Master ON dbo.Order_Master.PRTNUM_10 = dbo.Part_Master.PRTNUM_01
WHERE     (dbo.Order_Master.DUEQTY_10 > 0) AND (dbo.Order_Master.STATUS_10 = 3) AND (dbo.Order_Master.ORDNUM_10 LIKE '7%')


GO


/****** Object:  View [dbo].[MAXMonthlyScrap]    Script Date: 11/11/2010 14:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXMonthlyScrap]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXMonthlyScrap] END
GO

CREATE VIEW [dbo].[MAXMonthlyScrap]
AS
SELECT     CONVERT(CHAR(7), TNXDTE_15, 20) AS Month, DEFECT_15, SUM(TNXQTY_15) AS SQTY, COST_15 * TNXQTY_15 AS ExtCst
FROM         dbo.Transaction_History
WHERE     (TNXCDE_15 = 'Y')
GROUP BY CONVERT(CHAR(7), TNXDTE_15, 20), DEFECT_15, COST_15, TNXCDE_15, TNXQTY_15

GO


/****** Object:  View [dbo].[MAXNetChangeAdjustments]    Script Date: 11/11/2010 14:51:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXNetChangeAdjustments]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXNetChangeAdjustments] END
GO

CREATE VIEW [dbo].[MAXNetChangeAdjustments]
AS
SELECT     TOP (100) PERCENT CONVERT(CHAR(7), TNXDTE_15, 20) AS AMonth, SUM(COST_15) AS ACst, TNXCDE_15 AS A
FROM         dbo.Transaction_History
WHERE     (TNXDTE_15 >= DATEADD(m, - 6, GETDATE())) AND (TNXCDE_15 = 'A')
GROUP BY TNXCDE_15, CONVERT(CHAR(7), TNXDTE_15, 20)
ORDER BY AMonth

GO



/****** Object:  View [dbo].[MAXNetChangeAllTransactions]    Script Date: 11/11/2010 14:51:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXNetChangeAllTransactions]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXNetChangeAllTransactions] END
GO

CREATE VIEW [dbo].[MAXNetChangeAllTransactions]
AS
SELECT     TOP (100) PERCENT CONVERT(CHAR(7), TNXDTE_15, 20) AS AllMonth, SUM(COST_15) AS AllCst, TNXCDE_15 AS AllCde
FROM         dbo.Transaction_History
WHERE     (TNXDTE_15 >= DATEADD(m, - 6, GETDATE()))
GROUP BY TNXCDE_15, CONVERT(CHAR(7), TNXDTE_15, 20)
ORDER BY AllMonth

GO



/****** Object:  View [dbo].[MAXNetChangeCycleCounts]    Script Date: 11/11/2010 14:50:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXNetChangeCycleCounts]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXNetChangeCycleCounts] END
GO

CREATE VIEW [dbo].[MAXNetChangeCycleCounts]
AS
SELECT     TOP (100) PERCENT CONVERT(CHAR(7), TNXDTE_15, 20) AS CMonth, SUM(COST_15) AS CCSt, TNXCDE_15 AS C
FROM         dbo.Transaction_History
WHERE     (TNXDTE_15 >= DATEADD(m, - 6, GETDATE())) AND (TNXCDE_15 = 'C')
GROUP BY TNXCDE_15, CONVERT(CHAR(7), TNXDTE_15, 20)
ORDER BY CMonth

GO



/****** Object:  View [dbo].[MAXNetChangeIssues]    Script Date: 11/11/2010 14:50:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXNetChangeIssues]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXNetChangeIssues] END
GO

CREATE VIEW [dbo].[MAXNetChangeIssues]
AS
SELECT     TOP (100) PERCENT CONVERT(CHAR(7), TNXDTE_15, 20) AS IMonth, SUM(COST_15) AS ICst, TNXCDE_15 AS I
FROM         dbo.Transaction_History
WHERE     (TNXCDE_15 = 'I') AND (TNXDTE_15 >= DATEADD(m, - 6, GETDATE()))
GROUP BY TNXCDE_15, CONVERT(CHAR(7), TNXDTE_15, 20)
ORDER BY IMonth

GO


/****** Object:  View [dbo].[MAXNetChangeReceipts]    Script Date: 11/11/2010 14:50:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXNetChangeReceipts]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXNetChangeReceipts] END
GO

CREATE VIEW [dbo].[MAXNetChangeReceipts]
AS
SELECT     TOP (100) PERCENT CONVERT(CHAR(7), TNXDTE_15, 20) AS RMonth, SUM(COST_15) AS RCst, TNXCDE_15 AS R
FROM         dbo.Transaction_History
WHERE     (TNXCDE_15 = 'R') AND (TNXDTE_15 >= DATEADD(m, - 6, GETDATE()))
GROUP BY TNXCDE_15, CONVERT(CHAR(7), TNXDTE_15, 20)
ORDER BY RMonth

GO



/****** Object:  View [dbo].[MAXNetChangeShipments]    Script Date: 11/11/2010 14:50:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXNetChangeShipments]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXNetChangeShipments] END
GO

CREATE VIEW [dbo].[MAXNetChangeShipments]
AS
SELECT     TOP (100) PERCENT CONVERT(CHAR(7), TNXDTE_15, 20) AS SMonth, SUM(COST_15) AS SCst, TNXCDE_15 AS S
FROM         dbo.Transaction_History
WHERE     (TNXCDE_15 = 'S') AND (TNXDTE_15 >= DATEADD(m, - 6, GETDATE()))
GROUP BY TNXCDE_15, CONVERT(CHAR(7), TNXDTE_15, 20)
ORDER BY SMonth

GO



/****** Object:  View [dbo].[MAXOpenPOsSubtotals]    Script Date: 11/11/2010 14:54:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXOpenPOsSubtotals]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXOpenPOsSubtotals] END
GO

CREATE VIEW [dbo].[MAXOpenPOsSubtotals]
AS
SELECT     RTRIM(PRTNUM_10) AS PART_NUMBER, SUM(DUEQTY_10) AS DUE_QTY
FROM         dbo.Order_Master
WHERE     (TYPE_10 = 'PO') AND (STATUS_10 = '3')
GROUP BY RTRIM(PRTNUM_10)

GO



/****** Object:  View [dbo].[MAXOpenPurchaseOrders]    Script Date: 11/11/2010 16:19:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXOpenPurchaseOrders]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXOpenPurchaseOrders] END
GO

CREATE VIEW [dbo].[MAXOpenPurchaseOrders]
AS
SELECT     RTRIM(dbo.Order_Master.PRTNUM_10) AS PART_NUMBER, dbo.Order_Master.DUEQTY_10 AS DUE_QTY, CONVERT(varchar(20), 
                      dbo.Order_Master.CURDUE_10, 1) AS DUE_DATE, 
                      dbo.Order_Master.ORDNUM_10 + '-' + dbo.Order_Master.LINNUM_10 + '-' + dbo.Order_Master.DELNUM_10 AS ORDER_LINE_DEL, 
                      dbo.Vendor_Master.CONNAM_08 AS CONTACT, dbo.Vendor_Master.PHONE_08 AS PHONE, dbo.Vendor_Master.COMNAM_08 AS VENDOR_NAME
FROM         dbo.Order_Master INNER JOIN
                      dbo.Vendor_Master ON dbo.Order_Master.VENID_10 = dbo.Vendor_Master.VENID_08
WHERE     (dbo.Order_Master.TYPE_10 = 'PO') AND (dbo.Order_Master.STATUS_10 = '3')

GO


/****** Object:  View [dbo].[MAXPartMasterDetails]    Script Date: 11/11/2010 14:52:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPartMasterDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPartMasterDetails] END
GO

CREATE VIEW [dbo].[MAXPartMasterDetails]
AS
SELECT     RTRIM(PRTNUM_01) AS PART_NUMBER, TYPE_01 AS PART_TYPE, CLSCDE_01 AS CLASS_CODE, PLANID_01 AS PLANNER, 
                      COMCDE_01 AS COMMODITY_CODE, LLC_01 AS LOW_LEVEL_CODE, RTRIM(PMDES1_01) AS PART_DESC1, RTRIM(PMDES2_01) AS PART_DESC2, 
                      BOMUOM_01 AS [UOM - BOM], STAENG_01 AS ENG_STATUS, FRMPLN_01 AS FIRM_PLANNED, CONVERT(varchar(20), PRDDTE_01, 1) 
                      AS DATE_ADDED, WGTDEM_01 AS WEIGHT_UNIT, WGT_01 AS WEIGHT, DELSTK_01 AS PRIMARY_STKID, CYCCDE_01 AS CYCLE_COUNT_FREQ, 
                      CONVERT(varchar(20), CYCDTE_01, 1) AS CYCLE_COUNT_LAST, CYCNUM_01 AS CYCLE_COUNTS_YTD, CYCPER_01 AS [CYCLE_COUNT_TOL_%], 
                      CYCDOL_01 AS CYCLE_COUNT_TOL_$, CYCOOT_01 AS CYCLE_COUNT_OUT_OF_TOL, ORDPOL_01 AS ORDER_POLICY, YIELD_01 AS YIELD, 
                      CONVERT(varchar(20), TNXDTE_01, 1) AS LAST_TRANSACTION, ROP_01 AS REORDER_POINT, ROQ_01 AS REORDER_QTY, 
                      SAFSTK_01 AS SAFETY_STOCK, MINQTY_01 AS ORDER_QTY_MIN, MAXQTY_01 AS ORDER_QTY_MAX, MULQTY_01 AS ORDER_QTY_MULT, 
                      AVEQTY_01 AS ORDER_QTY_AVE, ISSMTD_01 AS ISSUES_MTD, ISSYTD_01 AS ISSUES_YTD, SALMTD_01 AS SALES_MTD, 
                      SALYTD_01 AS SALES_YTD, MFGLT_01 AS MFG_LEADTIME_TOTAL, MFGPIC_01 AS MFG_LEADTIME_PLAN, MFGOPR_01 AS MFG_LEADTIME_BUILD, 
                      MFGSTK_01 AS MFG_LEADTIME_STOCK, PURLT_01 AS PUR_LEADTIME_TOTAL, PURPIC_01 AS PUR_LEADTIME_PLAN, 
                      PUROPR_01 AS PUR_LEADTIME_BUY, PURSTK_01 AS PUR_LEADTIME_STOCK, COST_01 AS COST, CONVERT(varchar(20), CSTDTE_01, 1) 
                      AS COST_DATE_LAST, CSTUOM_01 AS [UOM - COST], CSTCNV_01 AS COST_CONVERSION, MATL_01 AS COST_MATL, LABOR_01 AS COST_LABOR, 
                      VOH_01 AS COST_OVERHEAD, FOH_01 AS COST_FIXED_MATL_OH, QUMMAT_01 AS COST_CUM_MATL, QUMLAB_01 AS COST_CUM_LABOR, 
                      QUMVOH_01 AS COST_CUM_OVERHEAD, QUMFOH_01 AS COST_CUM_FOH, QUMSUB_01 AS COST_CUM_SUBCNTR, BUYER_01 AS BUYER, 
                      INSRQD_01 AS INSPECTION_REQD, ONHAND_01 AS QTY_ON_HAND, NONNET_01 AS QTY_ON_HAND_NON_NET, REVLEV_01 AS REV_LEVEL, 
                      ACTTYP_01 AS ACCT_TYPE, MPNFLG_01 AS MANU_PART_NUMBER, LOTTRK_01 AS LOT_TRACKING, MULREC_01 AS MULTI_RECEIPTS, 
                      SERTRK_01 AS SERIAL_CONTROL, LOTSFC_01 AS LOT_SHOP_FLOOR, SHLIFE_01 AS SHELF_LIFE, SUBCST_01 AS COST_SUBCNTR, 
                      PERDAY_01 AS PERIOD_DAYS, RECVEN_01 AS PRIMARY_VENDOR, UDFKEY_01 AS UDFKEY, UDFREF_01 AS UDFREF, RTRIM(PCKG_01) 
                      AS PACKAGING_INSTR, ROHS_01 AS ROHS, NCNR_01 AS NON_COMFORMING
FROM         dbo.Part_Master

GO


/****** Object:  View [dbo].[MAXPartOnHandBase]    Script Date: 11/11/2010 14:47:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPartOnHandBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPartOnHandBase] END
GO

CREATE VIEW [dbo].[MAXPartOnHandBase]
AS
SELECT     PRTNUM_01, ONHAND_01, DATEDIFF(MONTH, TNXDTE_01, GETDATE()) AS Months, PMDES1_01, COST_01, CSTUOM_01, CSTCNV_01
FROM         dbo.Part_Master

GO


/****** Object:  View [dbo].[MAXPartOnHandBase]    Script Date: 11/11/2010 14:47:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPartOnHandBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPartOnHandBase] END
GO

CREATE VIEW [dbo].[MAXPartOnHandBase]
AS
SELECT     PRTNUM_01, ONHAND_01, DATEDIFF(MONTH, TNXDTE_01, GETDATE()) AS Months, PMDES1_01, COST_01, CSTUOM_01, CSTCNV_01
FROM         dbo.Part_Master

GO



/****** Object:  View [dbo].[MAXPartOnOrderBase]    Script Date: 11/11/2010 14:47:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPartOnOrderBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPartOnOrderBase] END
GO

CREATE VIEW [dbo].[MAXPartOnOrderBase]
AS
SELECT     PRTNUM_10, SUM(DUEQTY_10) AS OrderQty
FROM         dbo.Order_Master
WHERE     (DATEDIFF(MONTH, CURDUE_10, GETDATE()) > - 3)
GROUP BY PRTNUM_10
HAVING      (PRTNUM_10 IS NOT NULL)

GO


/****** Object:  View [dbo].[MAXPartRequirementsBase]    Script Date: 11/11/2010 14:47:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPartRequirementsBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPartRequirementsBase] END
GO

CREATE VIEW [dbo].[MAXPartRequirementsBase]
AS
SELECT     PRTNUM_11, SUM(DUEQTY_11) AS RQQty
FROM         dbo.Requirement_Detail
WHERE     (DATEDIFF(MONTH, CURDUE_11, GETDATE()) > - 3)
GROUP BY PRTNUM_11
HAVING      (SUM(DUEQTY_11) > 0)

GO


/****** Object:  View [dbo].[MAXPODetails]    Script Date: 11/11/2010 14:57:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPODetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPODetails] END
GO

CREATE VIEW [dbo].[MAXPODetails]
AS
SELECT     dbo.Part_Master.PRTNUM_01, dbo.Order_Master.ORDNUM_10 + '-' + dbo.Order_Master.LINNUM_10 + '-' + dbo.Order_Master.DELNUM_10 AS [Order], 
                      dbo.Order_Master.CURDUE_10 AS DueDate, dbo.Vendor_Master.COMNAM_08 AS VendorName, dbo.Part_Master.PMDES1_01 AS PartDesc, 
                      dbo.Buyers.BUYNME_95 AS BuyerName, RTRIM(dbo.Part_Master.PRTNUM_01) + ', ' + RTRIM(dbo.Part_Master.PMDES1_01) AS PartDescription, 
                      dbo.Order_Master.COST_10 * dbo.Order_Master.CURQTY_10 AS Value, dbo.Part_Master.COST_01 AS PartCost, dbo.Order_Master.COST_10 AS POCost,
                       dbo.Order_Master.COST_10 - dbo.Part_Master.COST_01 AS CostDelta, dbo.Part_Master.CSTUOM_01 AS CostUOM, 
                      dbo.Part_Master.CSTCNV_01 AS CostCnv, dbo.Part_Master.PURUOM_01 AS PurUOM, dbo.Part_Master.PURCNV_01 AS PurCnv, 
                      dbo.Order_Master.BUYER_10 AS Buyer, dbo.Order_Master.CREDTE_10 AS CreatedDate, dbo.Order_Master.GLREF_10 AS GLREF, 1 AS Count, 
                      dbo.Order_Master.CURQTY_10, dbo.Order_Master.DUEQTY_10 AS POQty, dbo.Order_Master.STATUS_10 AS Status
FROM         dbo.Buyers INNER JOIN
                      dbo.Order_Master INNER JOIN
                      dbo.Vendor_Master ON dbo.Order_Master.VENID_10 = dbo.Vendor_Master.VENID_08 INNER JOIN
                      dbo.Part_Master ON dbo.Order_Master.PRTNUM_10 = dbo.Part_Master.PRTNUM_01 ON 
                      dbo.Buyers.BUYID_95 = dbo.Order_Master.BUYER_10
WHERE     (dbo.Order_Master.TYPE_10 = 'PO')

GO


/****** Object:  View [dbo].[MAXPOReceiptDetails]    Script Date: 11/11/2010 14:45:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPOReceiptDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPOReceiptDetails] END
GO

CREATE VIEW [dbo].[MAXPOReceiptDetails]
AS
SELECT     ORDNUM_55, LINNUM_55, DELNUM_55, CONVERT(varchar(20), TNXDTE_55, 1) AS RECP_DATE, TNXQTY_55, RTRIM(PRTNUM_55) 
                      AS PART_NUMBER, ROUND(ORDCST_55 * TNXQTY_55, 2) AS EXT_PRICE, ROUND(COST_55 * TNXQTY_55, 2) AS EXT_COST
FROM         dbo.PO_Receipts

GO


/****** Object:  View [dbo].[MAXPOReceiptTotals]    Script Date: 11/11/2010 14:45:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPOReceiptTotals]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPOReceiptTotals] END
GO

CREATE VIEW [dbo].[MAXPOReceiptTotals]
AS
SELECT     dbo.MAXPOReceiptDetails.ORDNUM_55, dbo.MAXPOReceiptDetails.LINNUM_55, dbo.MAXPOReceiptDetails.DELNUM_55, 
                      SUM(dbo.MAXPOReceiptDetails.TNXQTY_55) AS RECPT_QTY, dbo.MAXPOReceiptDetails.PART_NUMBER, 
                      SUM(dbo.MAXPOReceiptDetails.EXT_PRICE) AS EXT_PRICE, SUM(dbo.MAXPOReceiptDetails.EXT_COST) AS EXT_COST, 
                      MAX(dbo.MAXPOReceiptDetails.RECP_DATE) AS LAST_RECPT
FROM         dbo.Part_Master INNER JOIN
                      dbo.MAXPOReceiptDetails ON dbo.Part_Master.PRTNUM_01 = dbo.MAXPOReceiptDetails.PART_NUMBER
GROUP BY dbo.MAXPOReceiptDetails.ORDNUM_55, dbo.MAXPOReceiptDetails.DELNUM_55, dbo.MAXPOReceiptDetails.PART_NUMBER, 
                      dbo.MAXPOReceiptDetails.LINNUM_55

GO


/****** Object:  View [dbo].[MAXPORequirements]    Script Date: 11/11/2010 14:53:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPORequirements]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPORequirements] END
GO

CREATE VIEW [dbo].[MAXPORequirements]
AS
SELECT     TOP (100) PERCENT RTRIM(dbo.Requirement_Detail.PRTNUM_11) AS PART_NUMBER, SUM(dbo.Requirement_Detail.DUEQTY_11) AS QTY_NEEDED, 
                      dbo.Requirement_Detail.ORDER_11 AS SHOP_ORDER, dbo.Part_Master.PLANID_01, dbo.Part_Master.BUYER_01, dbo.Part_Master.PURLT_01
FROM         dbo.Part_Master INNER JOIN
                      dbo.Requirement_Detail ON dbo.Part_Master.PRTNUM_01 = dbo.Requirement_Detail.PRTNUM_11 INNER JOIN
                      dbo.Order_Master ON dbo.Requirement_Detail.ORDER_11 = dbo.Order_Master.ORDER_10
WHERE     (dbo.Part_Master.TYPE_01 = 'B' OR
                      dbo.Part_Master.TYPE_01 = 'D' OR
                      dbo.Part_Master.TYPE_01 = 'Y') AND (dbo.Requirement_Detail.STATUS_11 = '3') AND (dbo.Order_Master.STATUS_10 = '3')
GROUP BY RTRIM(dbo.Requirement_Detail.PRTNUM_11), dbo.Requirement_Detail.ORDER_11, dbo.Part_Master.PLANID_01, dbo.Part_Master.BUYER_01, 
                      dbo.Part_Master.PURLT_01
ORDER BY PART_NUMBER

GO


/****** Object:  View [dbo].[MAXQuoteDetails]    Script Date: 11/11/2010 14:20:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXQuoteDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXQuoteDetails] END
GO

CREATE VIEW [dbo].[MAXQuoteDetails]
AS
SELECT     CONVERT(char(7), dbo.SO_Master.ORDDTE_27, 20) AS OrdMonth, CONVERT(char(7), dbo.SO_Detail.CURDUE_28, 20) AS DueMonth, CONVERT(char(7), 
                      dbo.SO_Detail.SHPDTE_28, 20) AS ShipMonth, dbo.SO_Master.NAME_27 AS CusNam, 
                      dbo.SO_Detail.ORDNUM_28 + '-' + dbo.SO_Detail.LINNUM_28 + '-' + dbo.SO_Detail.DELNUM_28 AS SONum, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * CURQTY_28 ELSE CURQTY_28 END AS Qty, dbo.SO_Detail.DUEQTY_28 AS DueQty, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * SHPQTY_28 ELSE SHPQTY_28 END AS ShpQty, dbo.SO_Detail.PRTNUM_28 AS PrtNum, 
                      dbo.Part_Sales.PMDES1_29 AS PrtDes, dbo.SO_Master.ORDDTE_27 AS OrdDte, dbo.SO_Detail.UDFKEY_28 AS RelDte, 
                      dbo.SO_Detail.REFRNC_28 AS Ref, 
                      CASE WHEN SType_28 = 'CR' THEN - 1 * dbo.SO_Detail.CURQTY_28 * dbo.SO_Detail.PRICE_28 ELSE dbo.SO_Detail.CURQTY_28 * dbo.SO_Detail.PRICE_28
                       END AS Value, dbo.SO_Detail.SHPDTE_28 AS ShpDte, dbo.SO_Detail.UDFREF_28 AS SN, dbo.SO_Detail.CURDUE_28 AS CurDue, 
                      dbo.SO_Detail.CUSDUE_28 AS CusDue, dbo.SO_Detail.STATUS_28 AS Status, dbo.SO_Detail.PRICE_28 AS Price, dbo.SO_Detail.DISC_28 AS Disc, 
                      dbo.Part_Sales.XDFFLT_29 AS XDFFLT, dbo.Part_Sales.XDFBOL_29 AS XDFBOL, dbo.SO_Detail.XDFTXT_28 AS XDFTXT, 
                      dbo.Part_Sales.PRDLIN_29 AS PrdLin, dbo.SO_Master.REP1_27 AS SlsRep, dbo.SO_Detail.ORDNUM_28 AS OrdNum, 
                      dbo.SO_Detail.LINNUM_28 AS LinNum, dbo.SO_Master.GLXREF_27 AS GLXRef, dbo.SO_Detail.STYPE_28 AS OrdTyp, 
                      dbo.Sales_Rep_Master.SLSTER_26 AS Territory, dbo.SO_Master.CUSTID_27 AS CustID
FROM         dbo.Part_Sales INNER JOIN
                      dbo.SO_Master INNER JOIN
                      dbo.SO_Detail ON dbo.SO_Master.ORDNUM_27 = dbo.SO_Detail.ORDNUM_28 ON 
                      dbo.Part_Sales.PRTNUM_29 = dbo.SO_Detail.PRTNUM_28 LEFT OUTER JOIN
                      dbo.Sales_Rep_Master ON dbo.SO_Master.REP1_27 = dbo.Sales_Rep_Master.SLSREP_26
WHERE     (dbo.SO_Detail.STYPE_28 = 'QT')

GO


/****** Object:  View [dbo].[MAXShopOrderNetAvailable]    Script Date: 11/11/2010 14:53:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXShopOrderNetAvailable]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXShopOrderNetAvailable] END
GO

CREATE VIEW [dbo].[MAXShopOrderNetAvailable]
AS
SELECT     dbo.Order_Master.ORDNUM_10, dbo.MAXPORequirements.PART_NUMBER, dbo.MAXPORequirements.QTY_NEEDED, 
                      dbo.MAXOpenPOsSubtotals.DUE_QTY AS QTY_ON_POs, RTRIM(dbo.Part_Master.PMDES1_01) AS PART_DESC, 
                      dbo.Part_Master.TYPE_01 AS PART_TYPE, ROUND(dbo.Part_Master.COST_01, 2) AS UNIT_COST, dbo.Part_Master.BUYER_01 AS BUYER, 
                      dbo.Part_Master.ONHAND_01 AS QTY_ON_HAND, ROUND(dbo.Part_Master.ONHAND_01 - dbo.MAXPORequirements.QTY_NEEDED, 0) 
                      AS ON_HAND_MINUS_NEEDED, 
                      ROUND(dbo.Part_Master.ONHAND_01 - dbo.MAXPORequirements.QTY_NEEDED + dbo.MAXOpenPOsSubtotals.DUE_QTY, 0) 
                      AS NET_AVAILABLE_AFTER_POs, dbo.Order_Master.ORDREF_10 AS REFERENCE
FROM         dbo.Order_Master INNER JOIN
                      dbo.MAXPORequirements ON dbo.Order_Master.ORDER_10 = dbo.MAXPORequirements.SHOP_ORDER INNER JOIN
                      dbo.MAXOpenPOsSubtotals ON dbo.MAXPORequirements.PART_NUMBER = dbo.MAXOpenPOsSubtotals.PART_NUMBER INNER JOIN
                      dbo.Part_Master ON dbo.Order_Master.PRTNUM_10 = dbo.Part_Master.PRTNUM_01
WHERE     (dbo.Order_Master.TYPE_10 = 'MF' OR
                      dbo.Order_Master.TYPE_10 = 'MS') AND (dbo.Order_Master.STATUS_10 = '3')

GO


/****** Object:  View [dbo].[MAXShopOrderNetAvailablePODetails]    Script Date: 11/11/2010 14:54:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXShopOrderNetAvailablePODetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXShopOrderNetAvailablePODetails] END
GO

CREATE VIEW [dbo].[MAXShopOrderNetAvailablePODetails]
AS
SELECT     dbo.MAXShopOrderNetAvailable.PART_NUMBER, dbo.MAXShopOrderNetAvailable.ORDNUM_10 AS SHOP_ORDER_NUMBER, 
                      dbo.MAXShopOrderNetAvailable.PART_DESC, dbo.MAXShopOrderNetAvailable.PART_TYPE, dbo.MAXShopOrderNetAvailable.UNIT_COST, 
                      dbo.MAXShopOrderNetAvailable.BUYER, CONVERT(varchar(10), dbo.MAXShopOrderNetAvailable.QTY_NEEDED) AS QTY_NEEDED, 
                      CONVERT(varchar(10), dbo.MAXShopOrderNetAvailable.QTY_ON_HAND) AS QTY_ON_HAND, CONVERT(varchar(10), 
                      dbo.MAXShopOrderNetAvailable.ON_HAND_MINUS_NEEDED) AS ON_HAND_MINUS_NEEDED, CONVERT(varchar(10), 
                      dbo.MAXShopOrderNetAvailable.QTY_ON_POs) AS QTY_ON_POs, CONVERT(varchar(10), 
                      dbo.MAXShopOrderNetAvailable.NET_AVAILABLE_AFTER_POs) AS NET_AVAIL_AFTER_POs, dbo.MAXOpenPurchaseOrders.ORDER_LINE_DEL, 
                      dbo.MAXOpenPurchaseOrders.DUE_QTY, dbo.MAXOpenPurchaseOrders.DUE_DATE, dbo.MAXOpenPurchaseOrders.VENDOR_NAME, 
                      dbo.MAXOpenPurchaseOrders.CONTACT, dbo.MAXOpenPurchaseOrders.PHONE, dbo.MAXShopOrderNetAvailable.REFERENCE, 
                      dbo.MAXShopOrderNetAvailable.NET_AVAILABLE_AFTER_POs
FROM         dbo.MAXOpenPurchaseOrders INNER JOIN
                      dbo.MAXShopOrderNetAvailable ON dbo.MAXOpenPurchaseOrders.PART_NUMBER = dbo.MAXShopOrderNetAvailable.PART_NUMBER

GO



/****** Object:  View [dbo].[MAXWorkcenterLaborEfficiency]    Script Date: 11/11/2010 14:56:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXWorkcenterLaborEfficiency]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXWorkcenterLaborEfficiency] END
GO

CREATE VIEW [dbo].[MAXWorkcenterLaborEfficiency]
AS
SELECT     TOP (100) PERCENT WORK_CNTR, WORK_CNTR_DESC, SUM(RUN_TIME_STD) AS RunTime, SUM(RUN_TIME_ACTUAL) AS RunTimeActual, 
                      SUM(SET_UP_TIME_STD) AS Setup, SUM(SET_UP_TIME_ACTUAL) AS SetupActual
FROM         dbo.MAXJobProgress
GROUP BY WORK_CNTR, WORK_CNTR_DESC
ORDER BY WORK_CNTR

GO



/****** Object:  View [dbo].[MAXWorkcenterWeeklySchedule]    Script Date: 11/11/2010 14:56:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXWorkcenterWeeklySchedule]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXWorkcenterWeeklySchedule] END
GO

CREATE VIEW [dbo].[MAXWorkcenterWeeklySchedule]
AS
SELECT     TOP (100) PERCENT WORK_CNTR, SUM(QTY_REMAINING * RUN_TIME_STD + SET_UP_TIME_STD / QTY_PER) AS HrsB, 
                      HRSMAN_13 * (WRKUTL_13 / 100) * 5 AS HrsC
FROM         dbo.MAXJobProgress
WHERE     (ORDER_STATUS = 'OPEN')
GROUP BY WORK_CNTR, HRSMAN_13, WRKUTL_13
ORDER BY WORK_CNTR

GO


/****** Object:  View [dbo].[MAXCycleCountAccuracy]    Script Date: 11/11/2010 14:49:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXCycleCountAccuracy]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXCycleCountAccuracy] END
GO

CREATE VIEW [dbo].[MAXCycleCountAccuracy]
AS
SELECT     TOP (100) PERCENT PartID, Year, Month, COUNT(TNX_DATE) AS CountNumber, SUM(OOTSum) AS GoodCounts, SUM(OOTSum) 
                      * 100 / COUNT(TNX_DATE) * 100 / 100 AS AccuracyPercent, REFDES_15, TNX_DATE, TNXDTE_15
FROM         dbo.MAXCycleCountDetails
GROUP BY PartID, Year, Month, REFDES_15, TNX_DATE, TNXDTE_15
ORDER BY PartID

GO


/****** Object:  View [dbo].[MAXCycleCountDeltaDollarCalculations]    Script Date: 11/11/2010 14:52:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXCycleCountDeltaDollarCalculations]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXCycleCountDeltaDollarCalculations] END
GO


CREATE VIEW [dbo].[MAXCycleCountDeltaDollarCalculations]
AS
SELECT     TOP (100) 
                      PERCENT CASE WHEN dbo.MAXCycleCountDetails.StartValue = 0 THEN 0 ELSE ROUND(ABS(dbo.MAXCycleCountDetails.StartValue - dbo.MAXCycleCountDetails.EndValue)
                       / dbo.MAXCycleCountDetails.StartValue * 100, 1) END AS PrcntVar, TNX_DATE, Year, Month, DeltaValuePerUnit, DeltaValueTotal, EndValue, StartQty, 
                      OOTCheckValue, OOTCheckPrcnt, OOTSum, PrcntChange, StartValue, STKID_15, PartID, PartDesc, TNXCDE_15, CLSCDE_01, PLANID_01, COMCDE_01, 
                      PMDES2_01, BOMUOM_01, TYPE_01, COST_01, BUYER_01, ACTTYP_01, REVLEV_01, EndQty, REFDES_15
FROM         dbo.MAXCycleCountDetails

GO



/****** Object:  View [dbo].[MAXCycleCountDeltaSubtotals]    Script Date: 11/11/2010 14:52:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXCycleCountDeltaSubtotals]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXCycleCountDeltaSubtotals] END
GO

CREATE VIEW [dbo].[MAXCycleCountDeltaSubtotals]
AS
SELECT     TOP (100) PERCENT PartID, Year, Month, PartDesc, SUM(ROUND(StartValue, 0)) AS StartValueTotal, SUM(ROUND(EndValue, 0)) AS EndValueTotal, 
                      SUM(ROUND(DeltaValueTotal, 0)) AS DeltaValueTotal
FROM         dbo.MAXCycleCountDeltaDollarCalculations
GROUP BY PartID, PartDesc, Year, Month
ORDER BY PartID

GO



/****** Object:  View [dbo].[MAXCycleCountTotals]    Script Date: 11/11/2010 14:51:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXCycleCountTotals]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXCycleCountTotals] END
GO

CREATE VIEW [dbo].[MAXCycleCountTotals]
AS
SELECT     TOP (100) PERCENT dbo.MAXCycleCountAccuracy.CountNumber, dbo.MAXCycleCountAccuracy.GoodCounts, dbo.Part_Master.TYPE_01, 
                      dbo.Part_Master.CLSCDE_01, dbo.Part_Master.COMCDE_01, dbo.Part_Master.CYCDTE_01, dbo.Part_Master.ONHAND_01, 
                      dbo.Part_Master.ACTTYP_01, dbo.MAXCycleCountAccuracy.REFDES_15, dbo.MAXCycleCountDeltaSubtotals.PartID, 
                      dbo.MAXCycleCountDeltaSubtotals.Year, dbo.MAXCycleCountDeltaSubtotals.Month, dbo.MAXCycleCountDeltaSubtotals.PartDesc, dbo.MAXCycleCountDeltaSubtotals.StartValueTotal, dbo.MAXCycleCountDeltaSubtotals.EndValueTotal, 
                      dbo.MAXCycleCountDeltaSubtotals.DeltaValueTotal

FROM         dbo.MAXCycleCountDeltaSubtotals INNER JOIN
                      dbo.MAXCycleCountAccuracy ON dbo.MAXCycleCountDeltaSubtotals.PartID = dbo.MAXCycleCountAccuracy.PartID AND 
                      dbo.MAXCycleCountDeltaSubtotals.Year = dbo.MAXCycleCountAccuracy.Year AND 
                      dbo.MAXCycleCountDeltaSubtotals.Month = dbo.MAXCycleCountAccuracy.Month INNER JOIN
                      dbo.Part_Master ON dbo.MAXCycleCountDeltaSubtotals.PartID = dbo.Part_Master.PRTNUM_01

GO



/****** Object:  View [dbo].[MAXInventoryNetChange]    Script Date: 11/11/2010 14:51:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXInventoryNetChange]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXInventoryNetChange] END
GO

CREATE VIEW [dbo].[MAXInventoryNetChange]
AS
SELECT DISTINCT 
     Issues.ICst, Rcpts.RCst, Ship.SCst, Cyc.CCSt, Adj.ACst, (ISNULL(Rcpts.RCst, 0) - ISNULL(Issues.ICst, 0) - ISNULL(Ship.SCst, 0) + ISNULL(Adj.ACst, 0)) 
     / CASE WHEN Cyc.CCst = 0 THEN 1 WHEN Cyc.CCst IS NULL THEN 1 ELSE Cyc.CCst END AS NetChange, 
     dbo.MAXNetChangeAllTransactions.AllMonth
FROM dbo.MAXNetChangeAllTransactions LEFT OUTER JOIN
     (SELECT     ICst, IMonth
      FROM          dbo.MAXNetChangeIssues) AS Issues ON dbo.MAXNetChangeAllTransactions.AllMonth = Issues.IMonth LEFT OUTER JOIN
     (SELECT     SCst, SMonth
      FROM          dbo.MAXNetChangeShipments) AS Ship ON dbo.MAXNetChangeAllTransactions.AllMonth = Ship.SMonth LEFT OUTER JOIN
     (SELECT     RCst, RMonth
      FROM          dbo.MAXNetChangeReceipts) AS Rcpts ON dbo.MAXNetChangeAllTransactions.AllMonth = Rcpts.RMonth LEFT OUTER JOIN
     (SELECT     CCSt, CMonth
      FROM          dbo.MAXNetChangeCycleCounts) AS Cyc ON dbo.MAXNetChangeAllTransactions.AllMonth = Cyc.CMonth LEFT OUTER JOIN
     (SELECT     ACst, AMonth
      FROM          dbo.MAXNetChangeAdjustments) AS Adj ON dbo.MAXNetChangeAllTransactions.AllMonth = Adj.AMonth

GO



/****** Object:  View [dbo].[MAXOnHand]    Script Date: 11/11/2010 14:48:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXOnHand]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXOnHand] END
GO

CREATE VIEW [dbo].[MAXOnHand]
AS
SELECT     TOP (100) PERCENT dbo.MAXPartOnHandBase.PRTNUM_01 AS PRTNUM, dbo.MAXPartOnHandBase.PMDES1_01 AS PMDes1, 
                      dbo.MAXPartOnHandBase.COST_01 AS Cost, dbo.MAXPartOnHandBase.CSTUOM_01 AS CstUOM, dbo.MAXPartOnHandBase.CSTCNV_01 AS CstCnv, 
                      dbo.MAXPartOnHandBase.ONHAND_01 AS OHQty, 
                      CASE WHEN dbo.MAXPartOnOrderBase.OrderQty > 0 THEN dbo.MAXPartOnOrderBase.OrderQty ELSE 0 END AS OrderQty, 
                      CASE WHEN dbo.MAXPartRequirementsBase.RQQty > 0 THEN dbo.MAXPartRequirementsBase.RQQty ELSE 0 END AS RQQty, 
                      dbo.MAXPartOnHandBase.ONHAND_01 + (CASE WHEN dbo.MAXPartOnOrderBase.OrderQty > 0 THEN dbo.MAXPartOnOrderBase.OrderQty ELSE 0 END)
                       - (CASE WHEN dbo.MAXPartRequirementsBase.RQQty > 0 THEN dbo.MAXPartRequirementsBase.RQQty ELSE 0 END) AS NetQty, 
                      (dbo.MAXPartOnHandBase.ONHAND_01 + (CASE WHEN dbo.MAXPartOnOrderBase.OrderQty > 0 THEN dbo.MAXPartOnOrderBase.OrderQty ELSE 0 END))
                       - (CASE WHEN dbo.MAXPartRequirementsBase.RQQty > 0 THEN dbo.MAXPartRequirementsBase.RQQty ELSE 0 END) 
                      * dbo.MAXPartOnHandBase.COST_01 / dbo.MAXPartOnHandBase.CSTCNV_01 AS NetValue, dbo.MAXPartOnHandBase.Months
FROM         dbo.MAXPartOnHandBase LEFT OUTER JOIN
                      dbo.MAXPartOnOrderBase ON dbo.MAXPartOnHandBase.PRTNUM_01 = dbo.MAXPartOnOrderBase.PRTNUM_10 LEFT OUTER JOIN
                      dbo.MAXPartRequirementsBase ON dbo.MAXPartOnHandBase.PRTNUM_01 = dbo.MAXPartRequirementsBase.PRTNUM_11
WHERE     ((dbo.MAXPartOnHandBase.ONHAND_01 + (CASE WHEN dbo.MAXPartOnOrderBase.OrderQty > 0 THEN dbo.MAXPartOnOrderBase.OrderQty ELSE 0 END))
                       - (CASE WHEN dbo.MAXPartRequirementsBase.RQQty > 0 THEN dbo.MAXPartRequirementsBase.RQQty ELSE 0 END) 
                      * dbo.MAXPartOnHandBase.COST_01 / dbo.MAXPartOnHandBase.CSTCNV_01 > 0)
ORDER BY dbo.MAXPartOnHandBase.Months

GO


/****** Object:  View [dbo].[MAXPartShortage]    Script Date: 11/11/2010 14:53:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPartShortage]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPartShortage] END
GO

CREATE VIEW [dbo].[MAXPartShortage]
AS
SELECT     TOP (10) ON_HAND_MINUS_NEEDED, PART_NUMBER, SUM(QTY_NEEDED) AS Needed, QTY_ON_HAND AS OnHand, PART_DESC
FROM         dbo.MAXShopOrderNetAvailable
GROUP BY PART_NUMBER, QTY_ON_HAND, PART_DESC, ON_HAND_MINUS_NEEDED
ORDER BY Needed DESC

GO



/****** Object:  View [dbo].[MAXPOCommitmentDetails]    Script Date: 11/11/2010 14:46:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXPOCommitmentDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXPOCommitmentDetails] END
GO

CREATE VIEW [dbo].[MAXPOCommitmentDetails]
AS
SELECT     dbo.Order_Master.ORDNUM_10 AS ORDNUM, dbo.Order_Master.LINNUM_10 AS LINNUM, dbo.Order_Master.DELNUM_10 AS DELNUM, 
                      dbo.Order_Master.ORDNUM_10 + '-' + dbo.Order_Master.LINNUM_10 + '-' + dbo.Order_Master.DELNUM_10 AS [ORDER-LINE-DEL], 
                      CASE WHEN STATUS_10 = '3' THEN 'OPEN' WHEN STATUS_10 = '4' THEN 'COMPLETE' WHEN STATUS_10 = '5' THEN 'CLOSED' WHEN STATUS_10 = '6'
                       THEN 'CANCELLED' END AS STATUS_LINE, 
                      CASE WHEN dbo.Order_Master.TYPE_10 = 'PO' THEN 'PURCHASE ORDER' WHEN dbo.Order_Master.TYPE_10 = 'NI' THEN 'NON-INVENTORY' WHEN dbo.Order_Master.TYPE_10
                       = 'SO' THEN 'SUBCONTRACT ORDER' WHEN dbo.Order_Master.TYPE_10 = 'VO' THEN 'SEVICE ORDER' END AS ORDER_TYPE, 
                      dbo.Order_Master.STK_10 AS STKRM, RTRIM(dbo.Order_Master.PRTNUM_10) AS PART_NUMBER, RTRIM(dbo.Part_Master.PMDES1_01) 
                      AS PART_DESC, CONVERT(varchar(20), dbo.Order_Master.CURDUE_10, 1) AS CUR_DUE, CONVERT(varchar(20), dbo.Order_Master.CURPRM_10, 1) 
                      AS CUR_PROMISE, ROUND(dbo.Order_Master.CURQTY_10, 2) AS QTY_ORDERED, ROUND(dbo.Order_Master.DUEQTY_10, 2) AS QTY_DUE, 
                      ROUND(dbo.MAXPOReceiptTotals.RECPT_QTY, 2) AS QTY_RECD, ROUND(dbo.Order_Master.RECCOST_10, 4) AS UNIT_COST, 
                      ROUND(dbo.Order_Master.CURQTY_10 * dbo.Order_Master.RECCOST_10, 4) AS EXT_COST_ORDERED, 
                      ROUND(dbo.Order_Master.DUEQTY_10 * dbo.Order_Master.RECCOST_10, 4) AS EXT_COST_DUE, ROUND(dbo.Order_Master.COST_10, 4) 
                      AS UNIT_PRICE, ROUND(dbo.Order_Master.CURQTY_10 * dbo.Order_Master.COST_10, 4) AS EXT_PRICE_ORDERED, 
                      ROUND(dbo.Order_Master.DUEQTY_10 * dbo.Order_Master.COST_10, 4) AS EXT_PRICE_DUE, CONVERT(varchar(20), 
                      dbo.Purchase_Order_Code.ORDDTE_16, 1) AS ORDERED_ON, DAY(dbo.Order_Master.CURDUE_10) AS DAY, 
                      CASE WHEN MONTH(dbo.Order_Master.CURDUE_10) = 1 THEN 'JAN' WHEN MONTH(dbo.Order_Master.CURDUE_10) 
                      = 2 THEN 'FEB' WHEN MONTH(dbo.Order_Master.CURDUE_10) = 3 THEN 'MAR' WHEN MONTH(dbo.Order_Master.CURDUE_10) 
                      = 4 THEN 'APR' WHEN MONTH(dbo.Order_Master.CURDUE_10) = 5 THEN 'MAY' WHEN MONTH(dbo.Order_Master.CURDUE_10) 
                      = 6 THEN 'JUN' WHEN MONTH(dbo.Order_Master.CURDUE_10) = 7 THEN 'JUL' WHEN MONTH(dbo.Order_Master.CURDUE_10) 
                      = 8 THEN 'AUG' WHEN MONTH(dbo.Order_Master.CURDUE_10) = 9 THEN 'SEP' WHEN MONTH(dbo.Order_Master.CURDUE_10) 
                      = 10 THEN 'OCT' WHEN MONTH(dbo.Order_Master.CURDUE_10) = 11 THEN 'NOV' WHEN MONTH(dbo.Order_Master.CURDUE_10) 
                      = 12 THEN 'DEC' END AS MONTH, YEAR(dbo.Order_Master.CURDUE_10) AS YEAR, dbo.Purchase_Order_Code.VENID_16 AS VENDID, 
                      dbo.Vendor_Master.COMNAM_08 AS VENDOR_NAME, dbo.Buyers.BUYNME_95 AS BUYER, 
                      dbo.Purchase_Order_Code.UDFKEY_16 AS UDFKEY_ORDER, dbo.Purchase_Order_Code.UDFREF_16 AS UDFREF_ORDER, 
                      dbo.Order_Master.UDFKEY_10 AS UDFKEY_LINE, dbo.Order_Master.UDFREF_10 AS UDFREF_LINE, dbo.Order_Master.PURUOM_10 AS UOM, 
                      dbo.Order_Master.INSREQ_10 AS INSPECTN_REQD, dbo.Part_Master.COMCDE_01 AS COMMODITY_CODE, 
                      dbo.Part_Master.REVLEV_01 AS PART_REV, dbo.Part_Master.ACTTYP_01 AS ACCT_TYPE, dbo.Vendor_Master.ADDR1_08 AS ADDR1, 
                      dbo.Vendor_Master.ADDR2_08 AS ADDR2, dbo.Vendor_Master.ADDR3_08 AS ADDR3, dbo.Vendor_Master.CONNAM_08 AS CONTACT, 
                      dbo.Vendor_Master.STATUS_08 AS VENDOR_STATUS, dbo.Vendor_Master.ADDR4_08 AS ADDR4, dbo.Vendor_Master.ADDR5_08 AS ADDR5, 
                      dbo.Vendor_Master.ADDR6_08 AS ADDR6, dbo.Vendor_Master.CITY_08 AS CITY, dbo.Vendor_Master.STATE_08 AS STATE, 
                      dbo.Vendor_Master.ZIPCD_08 AS ZIP, dbo.Vendor_Master.CNTRY_08 AS COUNTRY, dbo.Purchase_Order_Code.ORDREV_16 AS ORDER_REV, 
                      dbo.MAX_Notes.NOTES_60 AS [NON-INV_PART], dbo.Order_Master.ORDREF_10 AS REFERENCE, dbo.MAXPOReceiptTotals.LAST_RECPT
FROM         dbo.Order_Master INNER JOIN
                      dbo.Purchase_Order_Code ON dbo.Order_Master.ORDNUM_10 = dbo.Purchase_Order_Code.ORDNUM_16 INNER JOIN
                      dbo.Vendor_Master ON dbo.Purchase_Order_Code.VENID_16 = dbo.Vendor_Master.VENID_08 INNER JOIN
                      dbo.MAXPOReceiptTotals ON dbo.Order_Master.ORDNUM_10 = dbo.MAXPOReceiptTotals.ORDNUM_55 AND 
                      dbo.Order_Master.LINNUM_10 = dbo.MAXPOReceiptTotals.LINNUM_55 AND 
                      dbo.Order_Master.DELNUM_10 = dbo.MAXPOReceiptTotals.DELNUM_55 LEFT OUTER JOIN
                      dbo.MAX_Notes ON dbo.Order_Master.ORDER_10 = dbo.MAX_Notes.KEY_60 LEFT OUTER JOIN
                      dbo.Part_Master ON dbo.Order_Master.PRTNUM_10 = dbo.Part_Master.PRTNUM_01 LEFT OUTER JOIN
                      dbo.Buyers ON dbo.Purchase_Order_Code.BUYID_16 = dbo.Buyers.BUYID_95

GO



/****** Object:  View [dbo].[MAXShipmentDetails]    Script Date: 11/11/2010 14:21:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[MAXShipmentDetails]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXShipmentDetails] END
GO

CREATE VIEW [dbo].[MAXShipmentDetails]
AS
SELECT     CONVERT(char(7), dbo.SO_Master.ORDDTE_27, 20) AS OrdMonth, CONVERT(char(7), dbo.ShipmentDetailsBase.TnxDte, 20) AS ShipMonth, 
                      dbo.ShipmentDetailsBase.TnxQty AS ShpQty, dbo.ShipmentDetailsBase.TnxDte AS ShpDte, dbo.SO_Master.NAME_27 AS CusNam, 
                      dbo.SO_Detail.ORDNUM_28 + '-' + dbo.SO_Detail.LINNUM_28 + '-' + dbo.SO_Detail.DELNUM_28 AS SONum, dbo.SO_Detail.CURQTY_28 AS Qty, 
                      dbo.SO_Detail.DUEQTY_28 AS DueQty, dbo.SO_Detail.SHPQTY_28, dbo.SO_Detail.PRTNUM_28 AS PrtNum, dbo.Part_Sales.PMDES1_29 AS PrtDes, 
                      dbo.SO_Master.ORDDTE_27 AS OrdDte, dbo.SO_Detail.UDFKEY_28 AS RelDte, dbo.SO_Detail.REFRNC_28 AS Ref, 
                      dbo.ShipmentDetailsBase.TnxQty * dbo.SO_Detail.PRICE_28 AS Value, dbo.SO_Detail.SHPDTE_28, dbo.SO_Detail.UDFREF_28 AS SN, 
                      dbo.SO_Detail.CURDUE_28 AS CurDue, dbo.SO_Detail.CUSDUE_28 AS CusDue, dbo.SO_Detail.STATUS_28 AS Status, 
                      dbo.SO_Detail.PRICE_28 AS Price, dbo.SO_Detail.DISC_28 AS Disc, dbo.Part_Sales.XDFFLT_29 AS XDFFLT, dbo.Part_Sales.XDFBOL_29 AS XDFBOL, 
                      dbo.SO_Detail.XDFTXT_28 AS XDFTXT, dbo.Part_Sales.PRDLIN_29 AS PrdLin, dbo.SO_Master.REP1_27 AS SlsRep, 
                      dbo.SO_Detail.ORDNUM_28 AS OrdNum, dbo.SO_Detail.LINNUM_28 AS LinNum, dbo.SO_Master.GLXREF_27 AS GLXRef, 
                      dbo.SO_Detail.STYPE_28 AS OrdTyp, dbo.Sales_Rep_Master.SLSTER_26 AS Territory, dbo.SO_Master.CUSTID_27 AS CustID
FROM         dbo.Part_Sales INNER JOIN
                      dbo.SO_Master INNER JOIN
                      dbo.SO_Detail ON dbo.SO_Master.ORDNUM_27 = dbo.SO_Detail.ORDNUM_28 ON 
                      dbo.Part_Sales.PRTNUM_29 = dbo.SO_Detail.PRTNUM_28 INNER JOIN
                      dbo.ShipmentDetailsBase ON dbo.SO_Detail.DELNUM_28 = dbo.ShipmentDetailsBase.DelNum AND 
                      dbo.SO_Detail.LINNUM_28 = dbo.ShipmentDetailsBase.LinNum AND 
                      dbo.SO_Detail.ORDNUM_28 = dbo.ShipmentDetailsBase.OrdNum LEFT OUTER JOIN
                      dbo.Sales_Rep_Master ON dbo.SO_Master.REP1_27 = dbo.Sales_Rep_Master.SLSREP_26

GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[OnTimeDelivery]', 'V') IS NOT NULL
BEGIN DROP VIEW [OnTimeDelivery] END
GO

CREATE VIEW [dbo].[OnTimeDelivery]
AS
SELECT     dbo.Part_Master.PRTNUM_01, dbo.Part_Master.PMDES1_01, dbo.Transaction_History.VENID_15, dbo.Vendor_Master.COMNAM_08, 
                      dbo.Order_Master.ORDER_10, dbo.Order_Master.CURDUE_10, CONVERT(char(7), dbo.Transaction_History.TNXDTE_15, 20) AS TnxMonth, 
                      dbo.Transaction_History.TNXDTE_15, DATEDIFF(Day, dbo.Order_Master.CURDUE_10, dbo.Transaction_History.TNXDTE_15) AS DaysLate, 
                      dbo.Order_Master.CURQTY_10, dbo.Transaction_History.TNXQTY_15, dbo.Part_Master.COST_01, dbo.Transaction_History.COST_15, 
                      dbo.Part_Master.BUYER_01, dbo.Part_Master.PLANID_01, dbo.Transaction_History.TNXCDE_15
FROM         dbo.Order_Master INNER JOIN
                      dbo.Transaction_History ON dbo.Order_Master.ORDER_10 = dbo.Transaction_History.ORDNUM_15 INNER JOIN
                      dbo.Part_Master ON dbo.Transaction_History.PRTNUM_15 = dbo.Part_Master.PRTNUM_01 INNER JOIN
                      dbo.Vendor_Master ON dbo.Transaction_History.VENID_15 = dbo.Vendor_Master.VENID_08
GO


/****** Object:  View [dbo].[ShipmentDetailsBase]    Script Date: 11/12/2010 12:37:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[ShipmentDetailsBase]', 'V') IS NOT NULL
BEGIN DROP VIEW [ShipmentDetailsBase] END
GO

CREATE VIEW [dbo].[ShipmentDetailsBase]
AS
SELECT    TNXDTE_15 AS TnxDte, ORDNUM_15, SUBSTRING(ORDNUM_15, 1, 8) AS OrdNum, SUBSTRING(ORDNUM_15, 9, 2) AS LinNum, 
          SUBSTRING(ORDNUM_15, 11, 2) AS DelNum, TNXQTY_15 AS TnxQty
FROM      dbo.Transaction_History
WHERE     (TNXCDE_15 = 'S')

GO

IF OBJECT_ID('[PartStockView]', 'V') IS NOT NULL
BEGIN DROP VIEW [PartStockView] END
GO

CREATE VIEW [dbo].[PartStockView]
AS
SELECT     TOP (100) PERCENT PRTNUM_06, STK_06, STATUS_06, QTYOH_06
FROM         dbo.Part_Stock
ORDER BY PRTNUM_06

GO

IF OBJECT_ID('[MAXVendorDeliveryPerformancebyMonth]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXVendorDeliveryPerformancebyMonth] END
GO

CREATE VIEW [dbo].[MAXVendorDeliveryPerformancebyMonth]
AS
SELECT     TOP (100) PERCENT TOTORD.Month AS TMonth, TOTLAT.TotalLate, TOTORD.TotalPOs, (TOTORD.TotalPOs - TOTLAT.TotalLate) 
                      * 100 / TOTORD.TotalPOs AS OnTimePer
FROM         (SELECT     COUNT(DISTINCT dbo.Order_Master.ORDER_10) AS TotalLate, CONVERT(char(7), dbo.Transaction_History.TNXDTE_15, 20) AS Month
                       FROM          dbo.Transaction_History INNER JOIN
                                              dbo.Order_Master ON dbo.Transaction_History.ORDNUM_15 = dbo.Order_Master.ORDER_10 AND 
                                              dbo.Transaction_History.TNXDTE_15 >= dbo.Order_Master.CURDUE_10 AND dbo.Transaction_History.TNXCDE_15 = 'R'
                       GROUP BY CONVERT(char(7), dbo.Transaction_History.TNXDTE_15, 20)) AS TOTLAT RIGHT OUTER JOIN
                          (SELECT     COUNT(DISTINCT Order_Master_1.ORDER_10) AS TotalPOs, CONVERT(char(7), Transaction_History_1.TNXDTE_15, 20) AS Month
                            FROM          dbo.Transaction_History AS Transaction_History_1 INNER JOIN
                                                   dbo.Order_Master AS Order_Master_1 ON Transaction_History_1.ORDNUM_15 = Order_Master_1.ORDER_10 AND 
                                                   Transaction_History_1.TNXCDE_15 = 'R'
                            GROUP BY CONVERT(char(7), Transaction_History_1.TNXDTE_15, 20)) AS TOTORD ON TOTLAT.Month = TOTORD.Month
ORDER BY TMonth


GO

IF OBJECT_ID('[MAXVendorQuality]', 'V') IS NOT NULL
BEGIN DROP VIEW [MAXVendorQuality] END
GO

CREATE VIEW [dbo].[MAXVendorQuality]
AS
SELECT     TOTRET.TotalReturns, TOTORD.TotalReceipts, (TOTORD.TotalReceipts - TOTRET.TotalReturns) * 100 / TOTORD.TotalReceipts AS PQ, 
                      TOTORD.Month AS TMonth
FROM         (SELECT     COUNT(DISTINCT ORDNUM_15) AS TotalReceipts, CONVERT(char(7), TNXDTE_15, 20) AS Month
                       FROM          dbo.Transaction_History
                       WHERE      (TNXCDE_15 = 'R') AND (VENID_15 <> '')
                       GROUP BY CONVERT(char(7), TNXDTE_15, 20)) AS TOTORD INNER JOIN
                          (SELECT     COUNT(DISTINCT ORDNUM_15) AS TotalReturns, CONVERT(char(7), TNXDTE_15, 20) AS Month
                            FROM          dbo.Transaction_History AS Transaction_History_1
                            WHERE      (TNXCDE_15 = 'R') AND (TNXQTY_15 < 0) AND (VENID_15 <> '')
                            GROUP BY CONVERT(char(7), TNXDTE_15, 20)) AS TOTRET ON TOTORD.Month = TOTRET.Month





























