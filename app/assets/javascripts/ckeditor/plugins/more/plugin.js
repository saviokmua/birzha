/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

/**
 * @file Code plugin.
 */

(function()
{var moreCmd =
        {
 exec : function( editor )
                {
                editor.insertHtml('<!--more-->');
                }
};

var pluginName = 'more';
// Реги...и..ем им. плагина .
CKEDITOR.plugins.add( pluginName,
{
       onLoad : function()
        {
                // Add the styles that renders our fake objects.
                CKEDITOR.addCss(
                        'img.cke_wordpress_more' +
                                '{' +
                                'background-image: url(' + CKEDITOR.getUrl( this.path + 'images/more_bug.gif' ) + ');' +
                                'background-position: right center;' +
                                'background-repeat: no-repeat;' +
                                'clear: both;' +
                                'display: block;' +
                                'float: none;' +
                                'width: 100%;' +
                                'border-top: #999999 1px dotted;' +
                                'height: 10px;' +
                                '}'
                );
        },

init : function( editor )
{//.обавл.ем команд. на нажа.ие кнопки
editor.addCommand( pluginName,moreCmd);
// .обавл.ем кнопо.к.
editor.ui.addButton( 'More',
{
label : 'Добавити тег <!--more-->',//Title кнопки
command : pluginName,
icon : this.path + 'more.gif'//.... к иконке
});
}
});
})();
