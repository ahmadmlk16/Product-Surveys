//
//  SurveyList.swift
//  ProductSurveys
//
//  Created by Ahmad Malik on 3/30/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct SurveyList: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData

    var body: some View {

            List {
                // Each survey struct has its own unique 'id' used by ForEach
                ForEach(userData.surveyList) { aSurvey in
                    NavigationLink(destination: SurveyDetails(survey: aSurvey)) {
                        SurveyItem(survey: aSurvey)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
            .navigationBarTitle(Text("Surveys Taken"), displayMode: .inline)
           
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(trailing:  EditButton())

    }
   
    /*
     -------------------------------
     MARK: - Delete Selected survey
     -------------------------------
     */
    /*
     IndexSet:  A collection of unique integer values that represent the indexes of elements in another collection.
     first:     The first integer in self, or nil if self is empty.
     */
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            userData.surveyList.remove(at: first)
        }
        // Set the global variable point to the changed list
        surveyStructList = userData.surveyList
    }
   
    /*
     -----------------------------
     MARK: - Move Selected survey
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
 
        userData.surveyList.move(fromOffsets: source, toOffset: destination)
       
        // Set the global variable point to the changed list
       surveyStructList = userData.surveyList
    }
}
 
 
struct MyFavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        SurveyList()
            .environmentObject(UserData())
    }
}
 
