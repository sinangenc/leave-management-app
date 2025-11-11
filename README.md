# 🧾 ABAP Cloud Leave Management App (RAP)

This **Leave Management Application** is built with **ABAP Cloud** and the **RESTful ABAP Programming Model (RAP)**.  
It allows employees to submit leave requests and enables managers to approve or reject them through the Fiori Elements interface.

The application was developed as a **learning and demo project** on **SAP BTP Trial (ABAP Environment)**.  
It demonstrates how to build a full RAP-based CRUD application, including **determinations**, **validations**, and **UI annotations**.

> **Note:**  
> In a real production system, RAP **Data Control Language (DCL)** roles are used to manage authorizations — for example, to ensure that employees only see their own requests and managers only see their team’s. However, since this project runs on **SAP BTP Trial**, which supports only **a single user**, no DCL or authorization logic was implemented. All leave requests are visible to the active user.

## 📘 Technologies: 

In this project, I mainly used the following technologies and concepts:
<!--
- **ABAP Dictionary Objects** – defined tables, data elements, and domains for reusable and consistent data structures  
- **Core Data Services (CDS)** – for defining entities, associations, and projections  
- **RAP (RESTful ABAP Programming Model)** – structured the app using business objects, behaviors, and service exposure
- **Behavior Definitions & Implementations** – to handle validations, determinations, and actions (Approve / Reject)  
- **Value Helps** – implemented CDS-based value helps for selections  
- **Message Classes** – used for custom validation messages and user-friendly error handling
- **UI Annotations** – to control how data is displayed (icons, visibility, grouping, etc.)
- **Fiori Elements** – added UI annotations to improve how data is displayed in List Report and Object Page  
- **Eclipse ADT (ABAP Development Tools)** – main development environment for coding, activation, and testing  
- **ABAP Cloud Environment (SAP BTP Trial)** – for developing and deploying the application  
-->
| Technology / Concept | Description |
|---------------------|-------------|
| **ABAP Dictionary Objects** | Defined tables, data elements, and domains for reusable and consistent data structures |
| **Core Data Services (CDS)** | For defining entities, associations, and projections |
| **RAP (RESTful ABAP Programming Model)** | Structured the app using business objects, behaviors, and service exposure |
| **Behavior Definitions & Implementations** | To handle validations, determinations, and actions (Approve / Reject) |
| **Value Helps** | Implemented CDS-based value helps for selections |
| **Message Classes** | Used for custom validation messages and user-friendly error handling |
| **UI Annotations** | To control how data is displayed (icons, visibility, grouping, etc.) |
| **Fiori Elements (OData V4)** | Added UI annotations to improve how data is displayed in List Report and Object Page |
| **Eclipse ADT (ABAP Development Tools)** | Main development environment for coding, activation, and testing |
| **ABAP Cloud Environment (SAP BTP Trial)** | For developing and deploying the application |

