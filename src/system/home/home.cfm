<cfprocessingDirective pageencoding="utf-8">
<div id="px-container">
    <md-toolbar class="home-title">
        <div class="md-toolbar-tools">
            <img src="system/assets/img/logo-example-50x50.png">
            <px-nav-bar flex></px-nav-bar>
            <md-button class="md-icon-button" aria-label="More" ng-click="toggleRight()">
                <md-icon class="material-icons">more_vert</md-icon>
            </md-button>
        </div>
    </md-toolbar>
    <div ui-view></div>
    <md-sidenav class="md-sidenav-right md-whiteframe-z2" md-component-id="right">
        <md-toolbar class="">
            <h2 class="md-toolbar-tools">Configurações</h2>
        </md-toolbar>
        <md-content ng-controller="SidenavCtrl" layout-align="center center" layout-padding>
            <form layout="row" layout-align="center center">
                <md-button ng-click="logout();" class="md-primary">
                    Sair do sistema
                </md-button>
            </form>
        </md-content>
    </md-sidenav>
</div>
