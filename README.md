#  API - Jus [Challenge]


Criação de uma API rest json que permite a criação e consumo de conteúdo.

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      3.0.2
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.1.4
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      SQLite3 (dev)
    </td>
  </tr>
</table>


## Initial settings to run the project

```bash
# clone the project
git clone https://github.com/caiodelucena/API-Jus.git

# enter the cloned directory
cd API-Jus

# install Ruby on Rails dependencies
bundle install 

# create the development and test databases
rails db:create

# create the tables
rails db:migrate

# run the project
rails s
```

The backend is available at `http://localhost:3000`.

## Tests

To run the tests:

```bash

# All tests
  rspec
```
 - Category
```bash
  ## Controller:
  rspec spec/requests/api/v1/categories_spec.rb

  ## Model:
  rspec spec/models/category_spec.rb
```
- Article
```bash
  ## Controller:
  rspec spec/requests/api/v1/articles_spec.rb

  ## Model:
  rspec spec/models/article_spec.rb
```
- Page
```bash
  ## Controller:
  rspec spec/requests/api/v1/pages_spec.rb

  ## Model:
  rspec spec/models/page_spec.rb
```


### API Endpoint

The following endpoints are available:

####  ° Categories 
| Endpoints                   | Usage                                     | 
| --------------------------- | ----------------------------------------- | 
| `GET /api/v1/categories`           | Get all of the categories.                    |
| `GET /api/v1/categories/:id`       | Get all articles of the categories.         |
| `POST /api/v1/categories`          | Create a category.                           | 
| `PATCH /api/v1/categories/:id`       | Edit the details of an existing category.     | 
| `DELETE /api/v1/categories/:id`    | Remove the category.                      |         

####  ° Articles 
| Endpoints                   | Usage                                     | 
| --------------------------- | ----------------------------------------- | 
| `GET /api/v1/articles`           | Get all of the articles.                    |
| `GET /api/v1/articles/:id`       | Get the details of a single article        |
| `POST /api/v1/articles`          | Create a article.                           | 
| `PATCH /api/v1/articles/:id`       | Edit the details of an existing article.     | 
| `DELETE /api/v1/articles/:id`    | Remove the article.                      |  

####  ° Pages 
| Endpoints                   | Usage                                     | 
| --------------------------- | ----------------------------------------- | 
| `GET /api/v1/pages/:article_id`       | Get the details of an article's pages       |
| `POST /api/v1/pages`          | Create the pages of an article.                           | 
| `PATCH /api/v1/pages/:article_id`       | Edit the page details of an existing article's page.     | 
| `DELETE /api/v1/pages/:article_id`    | Remove the pages.                      |  
### Use Insomnia to test the API

If you want to import the above requests into [Insomnia](https://insomnia.rest/download), use the file `data.json` at the root of this project.



