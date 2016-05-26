//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-animate
//= require angular-aria
//= require angular-material
//= require moment
//= require_tree .

// Re-assign the lowercase function
var lowercase = angular.lowercase;

/**
 * Filters a list based on the given query string. Excludes objects that have
 * already been used. Objects must have an 'id' field, which is used to identify
 * objects that have already been used. The 'description' field is used to match
 * the object with the query string.
 *
 * @param list The list to filter.
 * @param used List of objects that have been used and should be excluded from
 *             the match
 * @param query The query string that we are looking for. The object descriptions
 *              must begin with the query string.
 */
function filterListByQuery(list, used, query) {
    // Map to a list of used ids.
    used = used.map(function (x) { return x.id });

    // Filter out the used objects and then match by query.
    return list.filter(function(x) { return used.indexOf(x.id) === -1 })
                .filter(function (x) { return lowercase(x.description).indexOf(query) !== -1 });
}


app = angular.module('icsi-shift-scheduler', ['ngMaterial']);

app.config(function ($mdDateLocaleProvider) {
    $mdDateLocaleProvider.formatDate = function (date) {
        return moment(date).format('YYYY-MM-DD');
    };
});

/**
 * Allows the given scope to handle issue selection
 * @param $scope
 */
function handleIssues($scope) {
    $scope.issueSearchTerm = '';
    $scope.issues = gon.issues || [];

    // Populate the list of all issues from the API
    $.get('/issues', function(data) {
        $scope.allIssues = data;
        $scope.$apply();
    });

    // Clear the search term when the select box is closed.
    $scope.clearIssueSearchTerm = function() {
        $scope.issueSearchTerm = '';
    };

    // Find an issue based on the query string
    $scope.findIssues = function(query) {
        return filterListByQuery($scope.allIssues, $scope.issues, lowercase(query));
    };

    // Watch the number of issues and update the hidden input so that issues submit with the
    // form
    $scope.$watch('issues.length', function() {
        $('#issue_ids').val($scope.issues.map(function(x) {return x.id }));
    });
}

/**
 * Allows the scope to handle skill selection.
 * @param $scope
 */
function handleSkills($scope) {
    $scope.skillSearchTerm = '';
    $scope.skills = gon.skills || [];

    // Populate the list of all skills from the API
    $.get('/skills', function(data) {
        $scope.allSkills = data;
        $scope.$apply();
    });

    // Clear the search term when the select box is closed.
    $scope.clearSkillSearchTerm = function() {
        $scope.skillSearchTerm = '';
    };

    // Find a skill based on the query text
    $scope.findSkills = function(query) {
        return filterListByQuery($scope.allSkills, $scope.skills, lowercase(query));
    };

    // Watch the number of skills and update the hidden input so that the skills submit with the
    // form
    $scope.$watch('skills.length', function() {
        $('#skill_ids').val($scope.skills.map(function(x) { return x.id }));
    });
}

app.controller('EventController', function ($scope) {
    $scope.init = function () {
        $('.md-datepicker-input').attr('name', 'event[event_date]');
    };
    
    handleIssues($scope);

    // If an event date was passed in, use it in the date picker
    if (gon.event_date) {
        $scope.event_date = new Date(gon.event_date);
    }
});

app.controller('RegistrationController', function($scope) {
    handleIssues($scope);
    handleSkills($scope);
});

app.controller('ShiftController', function($scope) {
    handleSkills($scope);
});

// jQuery effects
$(document).ready(function() {
    // Hide the ownership transfer form by default.
    $('#transfer_ownership_form').hide();

    // Display the transfer ownership form when someone clicks the transfer ownership link.
    $('#transfer_ownership_link').click(function() {
        $('#transfer_ownership_form').toggle();
    });

    // Allow the search box to capture key presses.
    $('input.searchbox').on('keydown', function(ev) {
        ev.stopPropagation();
    });

    // Redraw elements that aren't rendering correcty in Safari.
    $('.redraw').hide().show(0);
});
