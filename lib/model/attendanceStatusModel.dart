class AttendanceStatusModel {
  Data? data;
  String? status;

  AttendanceStatusModel({this.data, this.status});

  AttendanceStatusModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  int? companyId;
  int? userId;
  int? locationId;
  String? clockInTime;
  String? clockOutTime;
  String? clockInIp;
  String? clockOutIp;
  String? workingFrom;
  String? late;
  String? halfDay;
  int? addedBy;
  int? lastUpdatedBy;
  String? latitude;
  String? longitude;
  String? clockInAddress;
  String? clockOutAddress;
  String? shiftStartTime;
  String? shiftEndTime;
  int? employeeShiftId;
  String? workFromType;
  String? status;
  String? isRegularise;
  String? reason;
  String? createdBy;
  String? updatedBy;
  String? clockInDate;
  Company? company;

  Data(
      {this.id,
      this.companyId,
      this.userId,
      this.locationId,
      this.clockInTime,
      this.clockOutTime,
      this.clockInIp,
      this.clockOutIp,
      this.workingFrom,
      this.late,
      this.halfDay,
      this.addedBy,
      this.lastUpdatedBy,
      this.latitude,
      this.longitude,
      this.clockInAddress,
      this.clockOutAddress,
      this.shiftStartTime,
      this.shiftEndTime,
      this.employeeShiftId,
      this.workFromType,
      this.status,
      this.isRegularise,
      this.reason,
      this.createdBy,
      this.updatedBy,
      this.clockInDate,
      this.company});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    locationId = json['location_id'];
    clockInTime = json['clock_in_time'];
    clockOutTime = json['clock_out_time'];
    clockInIp = json['clock_in_ip'];
    clockOutIp = json['clock_out_ip'];
    workingFrom = json['working_from'];
    late = json['late'];
    halfDay = json['half_day'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    clockInAddress = json['clock_in_address'];
    clockOutAddress = json['clock_out_address'];
    shiftStartTime = json['shift_start_time'];
    shiftEndTime = json['shift_end_time'];
    employeeShiftId = json['employee_shift_id'];
    workFromType = json['work_from_type'];
    status = json['status'];
    isRegularise = json['is_regularise'];
    reason = json['reason'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    clockInDate = json['clock_in_date'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['user_id'] = userId;
    data['location_id'] = locationId;
    data['clock_in_time'] = clockInTime;
    data['clock_out_time'] = clockOutTime;
    data['clock_in_ip'] = clockInIp;
    data['clock_out_ip'] = clockOutIp;
    data['working_from'] = workingFrom;
    data['late'] = late;
    data['half_day'] = halfDay;
    data['added_by'] = addedBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['clock_in_address'] = clockInAddress;
    data['clock_out_address'] = clockOutAddress;
    data['shift_start_time'] = shiftStartTime;
    data['shift_end_time'] = shiftEndTime;
    data['employee_shift_id'] = employeeShiftId;
    data['work_from_type'] = workFromType;
    data['status'] = status;
    data['is_regularise'] = isRegularise;
    data['reason'] = reason;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['clock_in_date'] = clockInDate;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? appName;
  String? companyEmail;
  String? companyPhone;
  String? logo;
  String? lightLogo;
  String? favicon;
  String? authTheme;
  String? sidebarLogoStyle;
  String? loginBackground;
  String? address;
  String? website;
  int? currencyId;
  String? timezone;
  String? dateFormat;
  String? datePickerFormat;
  String? yearStartsFrom;
  String? momentFormat;
  String? timeFormat;
  String? locale;
  String? latitude;
  String? longitude;
  String? leavesStartFrom;
  String? activeTheme;
  String? status;
  int? lastUpdatedBy;
  String? googleMapKey;
  String? taskSelf;
  int? roundedTheme;
  String? logoBackgroundColor;
  String? headerColor;
  int? beforeDays;
  int? afterDays;
  String? onDeadline;
  int? defaultTaskStatus;
  int? dashboardClock;
  int? ticketFormGoogleCaptcha;
  int? leadFormGoogleCaptcha;
  int? taskboardLength;
  int? datatableRowLimit;
  int? allowClientSignup;
  int? adminClientSignupApproval;
  String? googleCalendarStatus;
  String? googleClientId;
  String? googleClientSecret;
  String? googleCalendarVerificationStatus;
  String? googleId;
  String? name;
  String? token;
  String? hash;
  String? lastLogin;
  int? rtl;
  int? showNewWebhookAlert;
  String? pmType;
  String? pmLastFour;
  String? logoUrl;
  String? loginBackgroundUrl;
  String? momentDateFormat;
  String? faviconUrl;

  Company(
      {this.id,
      this.companyName,
      this.appName,
      this.companyEmail,
      this.companyPhone,
      this.logo,
      this.lightLogo,
      this.favicon,
      this.authTheme,
      this.sidebarLogoStyle,
      this.loginBackground,
      this.address,
      this.website,
      this.currencyId,
      this.timezone,
      this.dateFormat,
      this.datePickerFormat,
      this.yearStartsFrom,
      this.momentFormat,
      this.timeFormat,
      this.locale,
      this.latitude,
      this.longitude,
      this.leavesStartFrom,
      this.activeTheme,
      this.status,
      this.lastUpdatedBy,
      this.googleMapKey,
      this.taskSelf,
      this.roundedTheme,
      this.logoBackgroundColor,
      this.headerColor,
      this.beforeDays,
      this.afterDays,
      this.onDeadline,
      this.defaultTaskStatus,
      this.dashboardClock,
      this.ticketFormGoogleCaptcha,
      this.leadFormGoogleCaptcha,
      this.taskboardLength,
      this.datatableRowLimit,
      this.allowClientSignup,
      this.adminClientSignupApproval,
      this.googleCalendarStatus,
      this.googleClientId,
      this.googleClientSecret,
      this.googleCalendarVerificationStatus,
      this.googleId,
      this.name,
      this.token,
      this.hash,
      this.lastLogin,
      this.rtl,
      this.showNewWebhookAlert,
      this.pmType,
      this.pmLastFour,
      this.logoUrl,
      this.loginBackgroundUrl,
      this.momentDateFormat,
      this.faviconUrl});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    appName = json['app_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    logo = json['logo'];
    lightLogo = json['light_logo'];
    favicon = json['favicon'];
    authTheme = json['auth_theme'];
    sidebarLogoStyle = json['sidebar_logo_style'];
    loginBackground = json['login_background'];
    address = json['address'];
    website = json['website'];
    currencyId = json['currency_id'];
    timezone = json['timezone'];
    dateFormat = json['date_format'];
    datePickerFormat = json['date_picker_format'];
    yearStartsFrom = json['year_starts_from'];
    momentFormat = json['moment_format'];
    timeFormat = json['time_format'];
    locale = json['locale'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    leavesStartFrom = json['leaves_start_from'];
    activeTheme = json['active_theme'];
    status = json['status'];
    lastUpdatedBy = json['last_updated_by'];
    googleMapKey = json['google_map_key'];
    taskSelf = json['task_self'];
    roundedTheme = json['rounded_theme'];
    logoBackgroundColor = json['logo_background_color'];
    headerColor = json['header_color'];
    beforeDays = json['before_days'];
    afterDays = json['after_days'];
    onDeadline = json['on_deadline'];
    defaultTaskStatus = json['default_task_status'];
    dashboardClock = json['dashboard_clock'];
    ticketFormGoogleCaptcha = json['ticket_form_google_captcha'];
    leadFormGoogleCaptcha = json['lead_form_google_captcha'];
    taskboardLength = json['taskboard_length'];
    datatableRowLimit = json['datatable_row_limit'];
    allowClientSignup = json['allow_client_signup'];
    adminClientSignupApproval = json['admin_client_signup_approval'];
    googleCalendarStatus = json['google_calendar_status'];
    googleClientId = json['google_client_id'];
    googleClientSecret = json['google_client_secret'];
    googleCalendarVerificationStatus =
        json['google_calendar_verification_status'];
    googleId = json['google_id'];
    name = json['name'];
    token = json['token'];
    hash = json['hash'];
    lastLogin = json['last_login'];
    rtl = json['rtl'];
    showNewWebhookAlert = json['show_new_webhook_alert'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    logoUrl = json['logo_url'];
    loginBackgroundUrl = json['login_background_url'];
    momentDateFormat = json['moment_date_format'];
    faviconUrl = json['favicon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['app_name'] = appName;
    data['company_email'] = companyEmail;
    data['company_phone'] = companyPhone;
    data['logo'] = logo;
    data['light_logo'] = lightLogo;
    data['favicon'] = favicon;
    data['auth_theme'] = authTheme;
    data['sidebar_logo_style'] = sidebarLogoStyle;
    data['login_background'] = loginBackground;
    data['address'] = address;
    data['website'] = website;
    data['currency_id'] = currencyId;
    data['timezone'] = timezone;
    data['date_format'] = dateFormat;
    data['date_picker_format'] = datePickerFormat;
    data['year_starts_from'] = yearStartsFrom;
    data['moment_format'] = momentFormat;
    data['time_format'] = timeFormat;
    data['locale'] = locale;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['leaves_start_from'] = leavesStartFrom;
    data['active_theme'] = activeTheme;
    data['status'] = status;
    data['last_updated_by'] = lastUpdatedBy;
    data['google_map_key'] = googleMapKey;
    data['task_self'] = taskSelf;
    data['rounded_theme'] = roundedTheme;
    data['logo_background_color'] = logoBackgroundColor;
    data['header_color'] = headerColor;
    data['before_days'] = beforeDays;
    data['after_days'] = afterDays;
    data['on_deadline'] = onDeadline;
    data['default_task_status'] = defaultTaskStatus;
    data['dashboard_clock'] = dashboardClock;
    data['ticket_form_google_captcha'] = ticketFormGoogleCaptcha;
    data['lead_form_google_captcha'] = leadFormGoogleCaptcha;
    data['taskboard_length'] = taskboardLength;
    data['datatable_row_limit'] = datatableRowLimit;
    data['allow_client_signup'] = allowClientSignup;
    data['admin_client_signup_approval'] = adminClientSignupApproval;
    data['google_calendar_status'] = googleCalendarStatus;
    data['google_client_id'] = googleClientId;
    data['google_client_secret'] = googleClientSecret;
    data['google_calendar_verification_status'] =
        googleCalendarVerificationStatus;
    data['google_id'] = googleId;
    data['name'] = name;
    data['token'] = token;
    data['hash'] = hash;
    data['last_login'] = lastLogin;
    data['rtl'] = rtl;
    data['show_new_webhook_alert'] = showNewWebhookAlert;
    data['pm_type'] = pmType;
    data['pm_last_four'] = pmLastFour;
    data['logo_url'] = logoUrl;
    data['login_background_url'] = loginBackgroundUrl;
    data['moment_date_format'] = momentDateFormat;
    data['favicon_url'] = faviconUrl;
    return data;
  }
}
