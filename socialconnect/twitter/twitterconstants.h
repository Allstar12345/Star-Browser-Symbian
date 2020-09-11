/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */

#ifndef TWITTERCONSTANTS_H
#define TWITTERCONSTANTS_H

// Twitter URL defines.
#define ACCESS_TOKEN_URL "https://api.twitter.com/oauth/access_token"
#define ACCOUNT_TOTALS_URL "https://api.twitter.com/1.1/account/totals.json"
#define AUTHENTICATE_URL "https://api.twitter.com/oauth/authenticate"
#define REQUEST_TOKEN_URL "https://api.twitter.com/oauth/request_token"
#define UPDATE_URL "https://api.twitter.com/1.1/statuses/update.json"
//#define UPDATE_WITH_MEDIA_URL "https://upload.twitter.com/1.1/statuses/update_with_media.json"
#define UPDATE_WITH_MEDIA_URL "https://api.twitter.com/1.1/statuses/update_with_media.json"
#define USER_TIMELINE_URL "https://api.twitter.com/1.1/statuses/user_timeline.json"

// OAuth request parameter string defines & Twitter request parameter defines.
#define OAUTH_CALLBACK "oauth_callback"
#define OAUTH_CALLBACK_CONFIRMED "oauth_callback_confirmed"
#define OAUTH_CONSUMER_KEY "oauth_consumer_key"
#define OAUTH_NONCE "oauth_nonce"
#define OAUTH_SIGNATURE "oauth_signature"
#define OAUTH_SIGNATURE_METHOD "oauth_signature_method"
#define OAUTH_TIMESTAMP "oauth_timestamp"
#define OAUTH_TOKEN "oauth_token"
#define OAUTH_TOKEN_SECRET "oauth_token_secret"
#define OAUTH_VERIFIER "oauth_verifier"
#define OAUTH_VERSION "oauth_version"
#define TWITTER_MESSAGE_COUNT "count"
#define TWITTER_SCREEN_NAME "screen_name"
#define TWITTER_STATUS_UPDATE "status"
#define TWITTER_USER_ID "user_id"
#define TWITTER_MAX_ID "max_id"
#define TWITTER_SINCE_ID "since_id"

// Defines for QSettings.
#define SETTINGS_ACCESS_TOKEN "access_token"
#define SETTINGS_ACCESS_TOKEN_SECRET "access_token_secret"
#define SETTINGS_SCREEN_NAME "screen_name"

// Defines for Message.
#define MESSAGE_DESCRIPTION "description"
#define MESSAGE_COUNT "updates"
#define MESSAGE_ID "id"
#define MESSAGE_TEXT "text"
#define MESSAGE_URL "url"

// HTTP method names, used with creating the base signature.
#define HTTP_GET "GET"
#define HTTP_POST "POST"

// HTTP request headers & values
#define HTTP_HEADER_AUTHORIZATION "Authorization"
#define HTTP_HEADER_HOST "Host"
#define HTTP_HEADER_CONTENT_TYPE "Content-Type"
#define HTTP_HEADER_CONTENT_LENGTH "Content-Length"
#define HTTP_HEADER_VALUE_FORM_URLENCODED "application/x-www-form-urlencoded"
#define HTTP_HEADER_VALUE_TWITTER_API "api.twitter.com"
#define HTTP_HEADER_VALUE_TWITTER_UPLOAD "api.twitter.com"
#define HTTP_HEADER_VALUE_FORM_DATA_BOUNDARY "multipart/form-data; boundary="

#endif // TWITTERCONSTANTS_H
