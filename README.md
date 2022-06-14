# Azure Data Engineering Cookbook

<a href="https://www.packtpub.com/product/Azure-Data-Engineering-Cookbook/9781800206557?utm_source=github&utm_medium=repository&utm_campaign=9781800206557"><img src="https://static.packt-cdn.com/products/9781800206557/cover/smaller" alt="Azure Data Engineering Cookbook" height="256px" align="right"></a>

This is the code repository for [Azure Data Engineering Cookbook](https://www.packtpub.com/product/Azure-Data-Engineering-Cookbook/9781800206557?utm_source=github&utm_medium=repository&utm_campaign=9781800206557), published by Packt.

**Design and implement batch and streaming analytics using Azure Cloud Services**

## What is this book about?
Data engineering is a growing field that focuses on preparing data for analysis. This book uses various Azure services to implement and maintain infrastructure to extract data from multiple sources, and then transform and load it for data analysis.

This book takes you through different techniques for performing big data engineering using Microsoft cloud services. It begins by showing you how Azure Blob storage can be used for storing large amounts of unstructured data and how to use it for orchestrating a data workflow. You'll then work with different Cosmos DB APIs and Azure SQL Database. Moving on, you'll discover how to provision an Azure Synapse database and find out how to ingest and analyze data in Azure Synapse. As you advance, you'll cover the design and implementation of batch processing solutions using Azure Data Factory, and understand how to manage, maintain, and secure Azure Data Factory pipelines. You’ll also design and implement batch processing solutions using Azure Databricks and then manage and secure Azure Databricks clusters and jobs. In the concluding chapters, you'll learn how to process streaming data using Azure Stream Analytics and Data Explorer.

By the end of this Azure book, you'll have gained the knowledge you need to be able to orchestrate batch and real-time ETL workflows in Microsoft Azure.

This book covers the following exciting features: 
* Use Azure Blob storage for storing large amounts of unstructured data
* Perform CRUD operations on the Cosmos Table API
* Implement elastic pools and business continuity with Azure SQL Database
* Ingest and analyze data using Azure Synapse Analytics
* Develop Data Factory data flows to extract data from multiple sources
* Manage, maintain, and secure Azure Data Factory pipelines
* Process streaming data using Azure Stream Analytics and Data Explorer

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1800206550) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders.

The code will look like the following:
```
#get blob reference
$blobs = Get-AzStorageBlob -Container $destcontainername -Context $storagecontext

#change the access tier of all the blobs in the container
$blobs.icloudblob.setstandardblobtier("Cool")

#verify the access tier
$blobs

```

**Following is what you need for this book:**
This book is for database administrators, database developers, and extract, load, transform (ETL) developers looking to build expertise in Azure Data engineering using a recipe-based approach. Technical architects and database architects with experience in designing data or ETL applications either on-premise or on any other cloud vendor who want to learn Azure Data engineering concepts will also find this book useful. Prior knowledge of Azure fundamentals and data engineering concepts is needed.

With the following software and hardware list you can run all code files present in the book (Chapter 1-9).

### Software and Hardware List

| Chapter  | Software required                                                                    | OS required                        |
| -------- | -------------------------------------------------------------------------------------| -----------------------------------|
|  1 - 9   |   Azure Subscription, Windows PowerShell, SSMS                               				| Windows, Mac OS X, and Linux (Any) |

We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://static.packt-cdn.com/downloads/9781800206557_ColorImages.pdf).


### Related products <Other books you may enjoy>
* Data Engineering with Python [[Packt]](https://www.packtpub.com/product/data-engineering-with-python/9781839214189) [[Amazon]](https://www.amazon.com/dp/183921418X)

* Python Data Cleaning Cookbook [[Packt]](https://www.packtpub.com/product/python-data-cleaning-cookbook/9781800565661) [[Amazon]](https://www.amazon.com/dp/1800565666)

## Get to Know the Author
**Ahmad Osama** works for Pitney Bowes Pvt Ltd as a database engineer and is a Microsoft Data Platform MVP. In his day to day job at Pitney Bowes, he works on developing and maintaining high performance on-premises and cloud SQL Server OLTP environments, building CI/CD environments for databases and automation. Other than his day to day work, he regularly speaks at user group events and webinars conducted by the DataPlatformLabs community.

