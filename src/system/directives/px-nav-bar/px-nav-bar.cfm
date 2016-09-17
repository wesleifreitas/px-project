<div id="menuDiv" class="navbar bg-dark px-no-radius" ng-controller="pxNavBarCtrl">
    <cfinvoke component="px-nav-bar" method="getNavBar" returnvariable="pxMenu">
    <div class="navbar-content px-no-radius">
        <a class="pull-menu" href="#"></a>
        <ul id="menu" class="element-menu px-no-radius">
            <cfoutput>#pxMenu#</cfoutput>
            <div class="element place-right px-pointer" ng-click="toggleRight()">
                <a class="element-menu">
                    <span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span>
                </a>
                <!--
            <ul class="dropdown-menu place-right" data-role="dropdown" ng-click="logout()">
                <li>
                    <i class="icon-exit on-left"></i>Sair
                </li>
            </ul>
            -->
            </div>
            <span class="element-divider place-right"></span>
            <button class="element image-button image-left place-right bg-dark">Phoenix Project - pxproject.com.br
                <img id="topMenuImgLogo" ng-src="{{logo}}" />
            </button>
        </ul>
    </div>
</div>
