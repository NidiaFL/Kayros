<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Login - SB Admin</title>
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body >

        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                    <div class="container-fluid">
                        <div class="row justify-content-center">
                            <div>
                                <br>
                                <br>
                                <br>
                            </div>
                            <div class="col-lg-4">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header text-center">
                                        <img src="img\logo.jpeg" width="100" height="100" >
                                        <h3 class="text-center font-weight-light my-4">Inicia sesión</h3></div>
                                    <div class="card-body">
                                        <form method="post" action="login.php">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputEmail" name="email" type="email" placeholder="name@example.com" />
                                            <label for="inputEmail">Correo</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputPassword" name="password" type="password" placeholder="Password" />
                                            <label for="inputPassword">Contraseña</label>
                                        </div>

                                    
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-danger">Login</button>
                                        </div>
                                    </form>

                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-secondary mt-auto">
                    <div class="container-fluid px-4">
                        <div class="text-sm-center">
                            <div class="text-muted">2023 - DIGISOFT
                                <a href="#">Política de Privacidad</a>
                               
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>