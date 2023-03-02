import 'package:iwl/pages/auth/model/user_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/daily/model/habit_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/model/chart_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/measure/model/measure_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/model/overview_response.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/model/rewards_response.dart';
import 'package:iwl/pages/introduction/model/common_response.dart';
import 'package:iwl/pages/sidebar/community/model/community_response.dart';
import 'package:iwl/pages/sidebar/exercise/model/exercise_response.dart';
import 'package:iwl/pages/sidebar/faq/model/faq_response.dart';
import 'package:iwl/pages/sidebar/feedback/model/feedback_response.dart';
import 'package:iwl/pages/sidebar/learn/model/learn_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/comments/model/pt_comments_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/habits/model/progress_tracker_graph_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/habits/model/progress_tracker_monthly_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/habits/model/progress_tracker_statistic_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/habits/model/progress_tracker_weekly_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/health/model/pt_health_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/waist/model/pt_waist_measurement_response.dart';
import 'package:iwl/pages/sidebar/progress_tracker/progress_tabs/weight/model/pt_weight_measurement_response.dart';
import 'package:iwl/pages/sidebar/recipes/model/recipes_category_response.dart';
import 'package:iwl/pages/sidebar/recipes/model/recipes_response.dart';
import 'package:iwl/pages/sidebar/resources/model/resources_response.dart';

class BaseResponse {
  bool? status;
  String? message;
  UserData? userData;
  List<HomeCarouselSlider>? homeCarouselSlider;
  Signup? signup;
  Overview? overview;
  Rewards? rewards;
  Habits? habits;
  Measure? measure;
  Chart? chart;
  Resources? resources;
  Exercise? exercise;
  Learn? learn;
  Community? community;
  Feedback? feedback;
  Faqs? faqs;
  RecipeCategory? recipeCategory;
  int? totalRecipes;
  int? servedRecipes;
  int? totalPages;
  List<Recipes>? recipes;
  Recipes? recipesDetail;
  ProgressTrackerWeekly? progressTrackerWeekly;
  ProgressTrackerMonthly? progressTrackerMonthly;
  ProgressTrackerGraph? progressTrackerGraph;
  ProgressTrackerStatistics? progressTrackerStatistics;
  List<PTWeightMeasurementIwl>? ptWeightMeasurementPreIwl;
  List<PTWeightMeasurementIwl>? ptWeightMeasurementIwl;
  List<PTWaistMeasurement>? ptWaistMeasurement;
  PTHealth? health;
  List<PTWeeklyComments>? ptWeeklyComments;

  BaseResponse({this.status, this.message, this.userData});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
    if (json['homeCarouselSlider'] != null) {
      homeCarouselSlider = <HomeCarouselSlider>[];
      json['homeCarouselSlider'].forEach((v) {
        homeCarouselSlider!.add(new HomeCarouselSlider.fromJson(v));
      });
    }
    signup =
        json['Signup'] != null ? new Signup.fromJson(json['Signup']) : null;
    overview = json['overview'] != null
        ? new Overview.fromJson(json['overview'])
        : null;
    rewards =
        json['rewards'] != null ? new Rewards.fromJson(json['rewards']) : null;
    habits =
        json['habits'] != null ? new Habits.fromJson(json['habits']) : null;
    measure =
        json['measure'] != null ? new Measure.fromJson(json['measure']) : null;
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
    resources = json['resources'] != null
        ? new Resources.fromJson(json['resources'])
        : null;
    exercise = json['exercise'] != null
        ? new Exercise.fromJson(json['exercise'])
        : null;
    learn = json['learn'] != null ? new Learn.fromJson(json['learn']) : null;
    community = json['community'] != null
        ? new Community.fromJson(json['community'])
        : null;
    feedback = json['feedback'] != null
        ? new Feedback.fromJson(json['feedback'])
        : null;
    faqs = json['faqs'] != null ? new Faqs.fromJson(json['faqs']) : null;
    recipeCategory = json['recipe_category'] != null
        ? new RecipeCategory.fromJson(json['recipe_category'])
        : null;
    totalRecipes = json['total_recipes'];
    servedRecipes = json['served_recipes'];
    totalPages = json['total_pages'];
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipes.fromJson(v));
      });
    }
    recipesDetail = json['recipe_detail'] != null
        ? new Recipes.fromJson(json['recipe_detail'])
        : null;
    progressTrackerWeekly = json['weekly'] != null
        ? ProgressTrackerWeekly.fromJson(json['weekly'])
        : null;
    progressTrackerMonthly = json['monthly'] != null
        ? ProgressTrackerMonthly.fromJson(json['monthly'])
        : null;
    progressTrackerGraph = json['graph'] != null
        ? new ProgressTrackerGraph.fromJson(json['graph'])
        : null;
    progressTrackerStatistics = json['statistics'] != null
        ? new ProgressTrackerStatistics.fromJson(json['statistics'])
        : null;
    if (json['preiwl'] != null) {
      ptWeightMeasurementPreIwl = <PTWeightMeasurementIwl>[];
      json['preiwl'].forEach((v) {
        ptWeightMeasurementPreIwl!.add(new PTWeightMeasurementIwl.fromJson(v));
      });
    }
    if (json['iwl'] != null) {
      ptWeightMeasurementIwl = <PTWeightMeasurementIwl>[];
      json['iwl'].forEach((v) {
        ptWeightMeasurementIwl!.add(new PTWeightMeasurementIwl.fromJson(v));
      });
    }

    if (json['waist_measurement'] != null) {
      ptWaistMeasurement = <PTWaistMeasurement>[];
      json['waist_measurement'].forEach((v) {
        ptWaistMeasurement!.add(new PTWaistMeasurement.fromJson(v));
      });
    }
    health = json['health'] != null ? PTHealth.fromJson(json['health']) : null;
    if (json['weekly_comments'] != null) {
      ptWeeklyComments = <PTWeeklyComments>[];
      json['weekly_comments'].forEach((v) {
        ptWeeklyComments!.add(PTWeeklyComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    if (this.homeCarouselSlider != null) {
      data['homeCarouselSlider'] =
          this.homeCarouselSlider!.map((v) => v.toJson()).toList();
    }
    if (this.signup != null) {
      data['Signup'] = this.signup!.toJson();
    }
    if (this.overview != null) {
      data['overview'] = this.overview!.toJson();
    }
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.toJson();
    }
    if (this.habits != null) {
      data['habits'] = this.habits!.toJson();
    }
    if (this.measure != null) {
      data['measure'] = this.measure!.toJson();
    }
    if (this.chart != null) {
      data['chart'] = this.chart!.toJson();
    }
    if (this.resources != null) {
      data['resources'] = this.resources!.toJson();
    }
    if (this.exercise != null) {
      data['exercise'] = this.exercise!.toJson();
    }
    if (this.learn != null) {
      data['learn'] = this.learn!.toJson();
    }
    if (this.community != null) {
      data['community'] = this.community!.toJson();
    }
    if (this.feedback != null) {
      data['feedback'] = this.feedback!.toJson();
    }
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.toJson();
    }
    if (this.recipeCategory != null) {
      data['recipe_category'] = this.recipeCategory!.toJson();
    }
    data['total_recipes'] = this.totalRecipes;
    data['served_recipes'] = this.servedRecipes;
    data['total_pages'] = this.totalPages;
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    if (this.recipesDetail != null) {
      data['recipe_detail'] = this.recipesDetail!.toJson();
    }
    if (this.progressTrackerWeekly != null) {
      data['weekly'] = this.progressTrackerWeekly!.toJson();
    }
    if (this.progressTrackerMonthly != null) {
      data['monthly'] = this.progressTrackerMonthly!.toJson();
    }
    if (this.progressTrackerGraph != null) {
      data['graph'] = this.progressTrackerGraph!.toJson();
    }
    if (this.progressTrackerStatistics != null) {
      data['statistics'] = this.progressTrackerStatistics!.toJson();
    }
    if (this.ptWeightMeasurementPreIwl != null) {
      data['preiwl'] =
          this.ptWeightMeasurementPreIwl!.map((v) => v.toJson()).toList();
    }
    if (this.ptWeightMeasurementIwl != null) {
      data['iwl'] =
          this.ptWeightMeasurementIwl!.map((v) => v.toJson()).toList();
    }
    if (this.ptWaistMeasurement != null) {
      data['waist_measurement'] =
          this.ptWaistMeasurement!.map((v) => v.toJson()).toList();
    }
    if (this.health != null) {
      data['health'] = this.health!.toJson();
    }
    if (this.ptWeeklyComments != null) {
      data['weekly_comments'] =
          this.ptWeeklyComments!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
