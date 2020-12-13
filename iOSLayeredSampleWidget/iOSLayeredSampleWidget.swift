//
//  iOSLayeredSampleWidget.swift
//  iOSLayeredSampleWidget
//
//  Created by rnishimu on 2020/08/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(.init(date: Date()))
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        .init(date: Date())
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entry: SimpleEntry = .init(date: Date())
        let timeline: Timeline<SimpleEntry> = .init(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct iOSLayeredSampleWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct iOSLayeredSampleWidget: Widget {
    private let kind: String = "iOSLayeredSampleWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            iOSLayeredSampleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(kind)
        .description("This is an example widget.")
    }
}

struct iOSLayeredSampleWidget_Previews: PreviewProvider {
    static var previews: some View {
        iOSLayeredSampleWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
