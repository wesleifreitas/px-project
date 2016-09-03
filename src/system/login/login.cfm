<form role="form" id="loginForm" name="loginForm" ng-submit="vm.login()">
    <div id="loginDiv" cd>
        <div id="headerDiv">
            <div>{{vm.formTitle}}</div>
        </div>
        <div class="animate-switch-container" ng-switch on="vm.selection">
            <div ng-switch-when="default" class="animate-switch">
                <fieldset>
                    <div class="input-control text" data-role="input">
                        <input id="username" name="username" type="text" class="form-control" placeholder="Usuário" ng-model="vm.username" required>
                        <button class="button helper-button clear"><span class="mif-cross"></span></button>
                    </div>
                    <div class="input-control password" data-role="input">
                        <input id="password" name="password" type="password" class="senha form-control" placeholder="Senha" ng-model="vm.password" required/>
                        <button class="button helper-button reveal"><span class="mif-looks"></span></button>
                    </div>
                    <!-- <i class="fa fa-keyboard-o lg fa-lg"></i> -->
                    <div id="loginControl" layout="row" layout-align="center center">
                        <md-button class="md-raised" type="submit" name="submit" value="Entrar" ng-disabled="loginForm.$invalid || vm.dataLoading">Entrar</md-button>                     
                    </div>
                </fieldset>
                <a ng-click="vm.showRecover()" class="recover-link" ng-show="!vm.dataLoading">Esqueci minha senha</a>
                <!-- <a ng-click="vm.showNewUser()" class="new-user-link" ng-show="!vm.dataLoading">Criar usuário</a> -->
            </div>
            <div ng-switch-when="recover" class="animate-switch">
                <fieldset>
                    <div class="input-control text" data-role="input">
                        <input id="usernameRecover" name="usernameRecover" type="text" class="form-control" placeholder="Usuário" ng-model="vm.username" required/>
                        <button class="button helper-button clear"><span class="mif-cross"></span></button>
                    </div>
                    <div class="input-control text" data-role="input">
                        <input id="email" type="text" class="form-control" placeholder="E-mail" ng-model="vm.email" required/>
                        <button class="button helper-button clear"><span class="mif-cross"></span></button>
                    </div>
                    <div id="loginRecover" layout="row" layout-align="center center">
                        <div class="btn-group">
                            <button class="btn btn-default" type="submit" name="submit" value="Confirmar" ng-disabled="loginForm.$invalid || vm.dataLoading" ng-click="vm.recover()">Confirmar</button>
                        </div>
                    </div>
                </fieldset>
                <a ng-click="vm.showLogin()" class="recover-link">Login</a>
            </div>
            <div ng-switch-when="redefine" class="animate-switch">
                <fieldset>
                    <div class="input-control text" data-role="input">
                        <input id="usu_senha_atual" name="usu_senha_atual" ng-model="vm.usu_senha_atual" class="form-control" type="password" placeholder="Senha atual" required ng-keyup="vm.redefineForm()" />
                        <button class="button helper-button clear"><span class="mif-cross"></span></button>
                        <small ng-show="loginForm.usu_senha_atual.$error.confirm" class="error">Senha atual incorreta</small>
                    </div>
                    <div class="input-control text" data-role="input">
                        <input id="usu_senha" name="usu_senha" ng-model="vm.usu_senha" class="form-control" type="password" placeholder="Nova senha" required ng-minlength="8" ng-keyup="vm.redefineForm()">
                        <button class="button helper-button clear"><span class="mif-cross"></span></button>
                        <small ng-show="loginForm.usu_senha.$error.minlength" class="error">A senha deve ter no mínimo 8 caracteres</small>
                        <small ng-show="loginForm.usu_senha.$error.equal" class="error">A senha deve diferente da atual</small>
                    </div>
                    <div class="input-control text" data-role="input">
                        <input id="usu_senha_confirmar" name="usu_senha_confirmar" ng-model="vm.usu_senha_confirmar" class="form-control" type="password" placeholder="Confirmar nova senha" required ng-minlength="8" ng-keyup="vm.redefineForm()">
                        <button class="button helper-button clear"><span class="mif-cross"></span></button>
                        <small ng-show="loginForm.usu_senha_confirmar.$error.confirm" class="error">Senha não confere</small>
                    </div>
                    <div id="loginredefinir" layout="row" layout-align="center center">
                        <div class="btn-group">
                            <button class="btn btn-default" type="submit" name="submit" value="Salvar" ng-disabled="loginForm.$invalid | loginWorking" ng-click="vm.redefine()">Salvar</button>
                        </div>
                    </div>
                </fieldset>
                <a ng-click="vm.showLogin()" class="recover-link">Cancelar</a>
            </div>
            <span ng-class="vm.dataLoading | loginWorking"></span>
            <span class="login-message">{{vm.loginMessage}}</span>
        </div>
    </div>
</form>
