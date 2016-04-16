// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-animate
//= require angular-aria
//= require angular-material
//= require moment
//= require_tree .

app = angular.module('icsi-shift-scheduler',['ngMaterial']);

app.config(function($mdDateLocaleProvider) {
    $mdDateLocaleProvider.formatDate = function(date) {
        return moment(date).format('YYYY-MM-DD');
    };
});

app.controller('EventsController', function($scope){
    $scope.init = function() {
        $('.md-datepicker-input').attr('name', 'event[event_date]');
    }
});
