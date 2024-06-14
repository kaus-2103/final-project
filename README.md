# Project Title

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Installation](#installation)

## Introduction
This project represents a commercial-grade web application developed using Ruby on Rails, completed independently during my internship. Through this project, I have honed my skills in full-stack web development, encompassing front-end design, back-end logic, database management, and deployment.

The project encompasses a variety of advanced features and adheres to industry best practices, ensuring high performance and maintainability. It demonstrates my ability to tackle complex problems, implement sophisticated functionalities, and deliver a polished, professional product ready for real-world use.

## Features
List the main features of your project.
- User Login/Registration System Using devise.
- Role Specific access to page and functionalities 
- Ability to Edit, Delete and Block Users. (Only by Admin)
- Creating Collections. Collection can have many items.
- On collection level, user can specify what kind of field item will have. For Example: User can select Either Author Name, Publication Date or Director Name and so on. User can put any amount of custom field
- User can delete and edit their own items and collections. And Any users can see those items and collections. 
- Ability to comment , like and dislike  on items
- Support English and Russian Localization.
- Supports Dark and Light Mode
- Supports Jira Integration. User can register on Jira through this website and can create a ticket on page specific routes with severity of priority
- User can create a API token to collect their all of their collections. 

## Installation
Step-by-step instructions on how to install and set up your project.

```bash
# Clone the repository
git clone [repo](https://github.com/kaus-2103/final-project)

# Navigate to the project directory
cd repository

# Install dependencies
bundle install

# Start Migration
bin/rails db:migrate or rails db:migrate

#Create User for Database
bin/rails db:seed or rails db:seed
```

