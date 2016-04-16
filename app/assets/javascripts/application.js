//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-animate
//= require angular-aria
//= require angular-material
//= require moment
//= require_tree .

app = angular.module('icsi-shift-scheduler', ['ngMaterial']);

app.config(function ($mdDateLocaleProvider) {
    $mdDateLocaleProvider.formatDate = function (date) {
        return moment(date).format('YYYY-MM-DD');
    };
});

app.controller('EventsController', function ($scope) {
    $scope.init = function () {
        $('.md-datepicker-input').attr('name', 'event[event_date]');
    }
});
