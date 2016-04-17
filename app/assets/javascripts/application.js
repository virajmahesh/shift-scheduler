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

app.controller('EventController', function ($scope) {
    $scope.init = function () {
        $('.md-datepicker-input').attr('name', 'event[event_date]');
    }
});

function skillID(skill) {
    return skill.id;
}

app.controller('RegistrationController', function($scope) {
    $scope.skills = [];

    // Populate the list of all skills from the API
    $.get('/skills', function(data) {
        $scope.allSkills = data;
    });

    $scope.findSkills = function(query) {
        var lowercaseQuery = angular.lowercase(query);

        function filterSkillsByQuery(s) {
            return (angular.lowercase(s.description).indexOf(lowercaseQuery) != -1);
        }

        function filterByUnused(s) {
            return $scope.skills.map(skillID).indexOf(s.id) == -1;
        }

        return $scope.allSkills.filter(filterByUnused).filter(filterSkillsByQuery);
    };

    $scope.$watch('skills.length', function() {
        $('#skills').val($scope.skills.map(skillID));
    });
});
