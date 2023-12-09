<%@ page import="java.util.ArrayList" %>
<%@ page import="lazyfood.demo.models.Bean.Product" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Product</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="./index.css">
    <style>
        .shadow-xl {
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .preview-image {
            width: 50%;
        }
    </style>

<body>
    <section
        style="display: flex; flex-direction: column; gap: 32px; align-items: self-start; flex: 6 1 0; padding : 32px 16px">
        <section
            style="display: flex; flex-direction: row-reverse; align-items: center; justify-content: space-between; gap: 16px; width: 100%; padding : 16px; border-radius: 24px;"
            class="shadow-xl">
            <button class="btn btn-primary" style="opacity: 0;">Back</button>
            <section style="width: 60%;">
                <input type="text"
                    style="padding: 12px 16px; border-radius: 8px; border: 1px solid rgb(128,128,128); width: 60%;"
                    placeholder="Search">
                <select id="searchClass" name="searchClass"
                    style="padding: 12px 16px; border-radius: 8px; border: 1px solid rgb(128,128,128);">
                    <option value="" selected="selected">Search By</option>
                    <option value="">Product ID</option>
                    <option value="">Product Name</option>
                </select>
            </section>
            <button class="btn btn-primary" onclick="history.back()">Back</button>
        </section>
    </section>

    <div class="container">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
                        <h2>Manage <b>Product</b></h2>
                    </div>
                    <div class="col-sm-6">
                        <a href="#addProductModal" class="btn btn-success" data-toggle="modal"><i
                                class="material-icons">&#xE147;</i> <span>Add New Product</span></a>

                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>

                        <th>Image</th>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Category Type</th>
                        <th>Price</th>

                    </tr>
                </thead>
                <tbody id="productBox">
                <%
                    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
                    Gson gson = new Gson();
                    String jsonProducts = gson.toJson(products);
                    for (int i = 0; i < products.size(); i++) { %>
                <tr>
                    <td style="width: 100px"><img src="data:image/jpeg;base64,<%=products.get(i).getImage()%>" width="80%" /></td>
                    <td><%= products.get(i).getProductId()%></td>
                    <td><%= products.get(i).getProductName()%></td>
                    <td><%= products.get(i).getCategoryName()%></td>
                    <td><%= products.get(i).getPrice()%></td>
                    <td>
                        <a href="#editProductModal" class="edit" data-toggle="modal" data-product-id=<%= products.get(i).getProductId()%> ><i
                                class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                        <a href="#deleteProductModal" class="delete" data-toggle="modal" data-product-id=<%= products.get(i).getProductId()%> ><i class="material-icons"
                                                                                                                                 data-toggle="tooltip" title="Delete" >&#xE872;</i></a>
                    </td>
                </tr>
                <%
                    }
                %>


                </tbody>
            </table>

        </div>
        <!-- Add Modal HTML -->
        <div id="addProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="Product/create" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h4 class="modal-title">Add Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Product ID</label>
                                <input type="text" class="form-control" name="ProductId" required>
                            </div>
                            <div class="form-group">
                                <label>Product Name</label>
                                <input type="text" class="form-control" name="ProductName" required>
                            </div>
                            <div class="form-group"
                                style="display:  flex ; align-items: center; justify-content: space-between;">
                                <label>Category</label>
                                <select name="CategoryId" id="">
                                    <option value="1" selected>Food</option>
                                    <option value="2">Drink</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input type="number" class="form-control" name="Price" required>
                            </div>

                            <div class="form-group">
                                <label>Image</label>
                                <input type="file" name="Image" id="image-input">
                            </div>

                            <div class="form-group" id="image-preview"></div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div id="editProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">

                </div>
            </div>
        </div>
        <!-- Delete Modal HTML -->
        <div id="deleteProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="Product/delete" method="delete">
                        <div class="modal-header">
                            <h4 class="modal-title">Delete Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="form-group">
                                <label hidden>Product ID</label>
                                <input hidden type="text" readonly class="form-control" name="ProductIdD" required>
                            </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete these Records?</p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
</body>

<script>
    const js_products = <%= jsonProducts %>;

    const editButtons = document.querySelectorAll('.edit');
    editButtons.forEach(function (editButton) {
        editButton.addEventListener('click', function (event) {
            event.preventDefault();

            const productId = this.getAttribute('data-product-id');
            populateFormFields(productId);
        });
    });

    // function getProductById(productId) {
    //     return js_products.find(prod => prod.ProductId == productId);
    // }


    function populateFormFields(productId) {
        $('#editProductModal .modal-content').load('./Product/update?ProductId=' + productId);
        // const productIdInput = document.querySelector('input[name="ProductIdE"]');
        // const productNameInput = document.querySelector('input[name="ProductNameE"]');
        // const categoryIdInput = document.querySelector('select[name="CategoryIdE"]');
        // const priceInput = document.querySelector('input[name="PriceE"]');
        //
        // productIdInput.value = product.ProductId;
        // productNameInput.value = product.ProductName;
        // categoryIdInput.value = product.CategoryId;
        // priceInput.value = product.Price;
    }

    const imageInput = document.getElementById('image-input');
    const imagePreview = document.getElementById('image-preview');

    imageInput.addEventListener('change', function (event) {
        const file = event.target.files[0];

        const reader = new FileReader();

        reader.onload = function (e) {
            const img = document.createElement('img');
            img.src = e.target.result;;
            img.classList.add('preview-image');
            imagePreview.innerHTML = '';
            imagePreview.appendChild(img);
        }

        reader.readAsDataURL(file);
    });

    const deleteButtons = document.querySelectorAll('.delete');
    deleteButtons.forEach(function (deleteButton) {
        deleteButton.addEventListener('click', function (event) {
            event.preventDefault();

            const productId = this.getAttribute('data-product-id');
            const productIdInput = document.querySelector('input[name="ProductIdD"]');
            productIdInput.value = productId;
        });
    });
</script>

</html>