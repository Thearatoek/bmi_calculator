package com.example.online

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class MyAppWidgetProvider : HomeWidgetProvider() {


    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
        val views = RemoteViews(context.packageName, R.layout.my_widget_layout)
        appWidgetManager.updateAppWidget(appWidgetIds, views)

        views.setOnClickPendingIntent(R.id.text, pendingIntent);
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val remoteViews = RemoteViews(context.packageName, R.layout.my_widget_layout)

        // Update your widget's content
        remoteViews.setTextViewText(R.id.text, "Updated Widget")

        // Update the widget
        appWidgetManager.updateAppWidget(appWidgetId, remoteViews)
    }
}