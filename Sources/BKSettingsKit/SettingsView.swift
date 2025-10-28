//
//  SettingsView.swift
//  BKSettingsKit
//
//  Created by Baturay Koc on 10/14/25.
//

import SwiftUI
import RevenueCatUI

public struct SettingsView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss
    
    @State private var isCustomerCenterPresented = false
    @Binding public var showPaywall: Bool
    @Binding public var showSettings: Bool
    
    private let config: SettingsConfig
    private let items: [SettingsItem]
    
    public init(config: SettingsConfig, items: [SettingsItem], showPaywall: Binding<Bool>, showSettings: Binding<Bool>) {
        self.config = config
        self.items = items
        _showPaywall = showPaywall
        _showSettings = showSettings
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                header
                itemList
                Spacer()
                footer
            }
        }
        .sheet(isPresented: $isCustomerCenterPresented) {
            CustomerCenterView()
        }
    }
}

private extension SettingsView {
    var header: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 25)
            if !config.isUserSubscribed {
                becomeProButton()
            }
        }
    }
    
    func becomeProButton() -> some View {
        Button(action: {
            showSettings = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
                showPaywall = true
            })
        }) {
            HStack(spacing: 15) {
                Image(systemName: "star.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Become a Pro")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                    Text("Unlock all premium features")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.8))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundColor(.black.opacity(0.8))
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.orange, Color.white],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(15)
            .shadow(color: Color.white.opacity(0.3), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 20)
        }
        .padding(.top)
    }
    
    var itemList: some View {
        VStack(spacing: 15) {
            ForEach(items) { item in
                settingsRow(for: item)
            }
        }
        .padding(.top, 35)
    }
    
    var footer: some View {
        return Text("Version: \(config.appVersion)\n\(config.companyName)")
            .font(.subheadline)
            .foregroundStyle(.white.opacity(0.5))
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func settingsRow(for item: SettingsItem) -> some View {
        switch item.action {
        case .shareApp(let link):
            ShareLink(item: link) {
                rowContent(for: item, showChevron: false)
            }
            .background(rowBackground)
            .padding(.horizontal, 25)
            
        default:
            Button { handleAction(item.action) } label: {
                rowContent(for: item, showChevron: showChevron(for: item.action))
            }
            .background(rowBackground)
            .padding(.horizontal, 25)
        }
    }
    
    var rowBackground: some View {
        Color.white.opacity(0.1)
            .cornerRadius(12)
    }
    
    func rowContent(for item: SettingsItem, showChevron: Bool) -> some View {
        HStack {
            Image(systemName: item.icon)
                .font(.body)
                .foregroundStyle(.white)
            Spacer()
            Text(item.title)
                .font(.body)
                .foregroundStyle(.white)
            Spacer()
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundStyle(.white)
            }
        }
        .frame(height: 55)
        .padding(.horizontal)
    }
}

private extension SettingsView {
    func showChevron(for action: SettingsAction) -> Bool {
        switch action {
        case .rateApp, .shareApp, .feedback:
            return false
        default:
            return true
        }
    }
    
    func handleAction(_ action: SettingsAction) {
        switch action {
        case .rateApp(let url):
            UIApplication.shared.open(url)
        case .feedback(let url):
            openURL(url)
            break
        case .openURL(let url):
            openURL(url)
        case .openSheet:
            isCustomerCenterPresented = true
        case .custom(let handler):
            handler()
        default:
            break
        }
    }
}
