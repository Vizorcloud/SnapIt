//
//  AuthViewModel.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/13/24.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    // View can observe changes on this
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var reports: Report?
    
    static let shared = AuthViewModel()
    
    init() {
//        self.userSession = Auth.auth().currentUser
//        
//        Task {
//            await fetchUser()
//        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print(currentUser ?? "None")
    }
    
    func saveImage(report: Report, image: UIImage) async -> Bool {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error")
            return false
        }
        
        let reportName = UUID().uuidString // Name of the image file
        let storage = Storage.storage() // Create firebase storage instance
        let storageRef = storage.reference().child("\(userID)/\(reportName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("Error: Could not resize image")
            return false
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg" // Setting metadata allows you to see console image in the web browser this setting will work for png as well as jpg
        var imageURLString = ""
        
        do {
            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
            print("Image Saved!")
            
            do {
                let imageURL = try await storageRef.downloadURL()
                imageURLString = "\(imageURL)" // We'll save this to cloud firestore as part of document in reports collection, below
            } catch {
                print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
                return false
            }
            
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            return false
        }
        
        // Now to save to the reports collection of the user document "userID"
        let db = Firestore.firestore()
        let collectionString = "users/\(userID)/reports"
        
        do {
            var newReport = report
            newReport.imageURLString = imageURLString
            try await db.collection(collectionString).document(reportName).setData(newReport.dictionary)
            print("Data uploaded successfully")
            return true
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            return false
        }
    }
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userID: String) -> DocumentReference {
        userCollection.document(userID)
    }
    
    private func userReportCollection(userID: String) -> CollectionReference {
        userDocument(userID: userID).collection("reports")
    }
    
    private func userReportDocument(userID: String, reportID: String) -> DocumentReference {
        userReportCollection(userID: userID).document(reportID)
    }
    
    func fetchAllUserReports(userID: String) async throws -> [UserReport] {
        let snapshot = try await userReportCollection(userID: userID).getDocuments()
        
//        for document in snapshot.documents {
//            print("\(document.documentID) => \(document.data())")
//            print("______________")
//        }
        
        // Map each document into a UserReport model
        let reports = snapshot.documents.compactMap { document -> UserReport? in
                // Try to decode each document as a UserReport
            do {
                return try document.data(as: UserReport.self)
            } catch {
                print("Error decoding document \(document.documentID): \(error)")
                return nil
            }
        }
        
        return reports
    }
}

struct UserReport: Codable, Identifiable {
    let id: UUID
    let imageURLString: String
    let dateCreated: Date
    let status: String
    let latitude: Float
    let longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURLString = "imageURLString"
        case dateCreated = "reportedOn"
        case status = "Status"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.imageURLString = try container.decode(String.self, forKey: .imageURLString)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        self.status = try container.decode(String.self, forKey: .status)
        self.latitude = try container.decode(Float.self, forKey: .latitude)
        self.longitude = try container.decode(Float.self, forKey: .longitude)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.imageURLString, forKey: .imageURLString)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
    }
}
