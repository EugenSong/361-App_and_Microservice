
import threading
import time
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use the application default credentials
cred = credentials.Certificate('./py_firebase/firebase-sdk.json')

app = firebase_admin.initialize_app(cred)

# initialize db
db = firestore.client()

# Create an Event for notifying main thread.
callback_done = threading.Event()

# Create a callback on_snapshot function to capture changes
# will run whenever there's a change
def on_snapshot(doc_snapshot, changes, read_time):
        
    # check changes
    for change in changes:
        if change.type.name == 'ADDED':
            print(f'New city: {change.document.id}')
            tally = 0
            putts = 0
            strokes = 0
            avg_putts_per_round = 18
            avg_strokes_per_round = 18
            
            #.get() is to get the changed document id within DocumentSnapshot
            scores_ref = db.collection('scores').document(change.document.id).get()
            scores_dict = scores_ref.to_dict()
            scores = scores_dict['scores']
            
            # total num of green false counts
            for score in scores:
                if score['green'] == True:
                    tally += 1
                if score['putts'] != None:
                    putts += score['putts']
                if score['strokes'] != None:
                    strokes += score['strokes'] 
                    
            # calculate avg putts
            avg_putts_per_round = putts // avg_putts_per_round
            
            # calculate avg strokes
            avg_strokes_per_round = strokes // avg_strokes_per_round
            
            # .collection().document() w/o .get() is to edit the document in database 
            update_score_ref = db.collection('scores').document(change.document.id)
            
            update_score_ref.set( {
                'green_successes':tally,
                'total_putts':putts,
                'total_strokes': strokes,
                'avg_putts':avg_putts_per_round,
                'avg_strokes':avg_strokes_per_round}, merge=True)
                
            # print(tally)
            # print(putts)
            # print(strokes)
            # print(avg_putts_per_round)
            # print(avg_strokes_per_round)   
        elif change.type.name == 'MODIFIED':
            print(f'Modified city: {change.document.id}')
            tally = 0
            putts = 0
            strokes = 0
            avg_putts_per_round = 18
            avg_strokes_per_round = 18
            
            #.get() is to get the changed document id within DocumentSnapshot
            scores_ref = db.collection('scores').document(change.document.id).get()
            scores_dict = scores_ref.to_dict()
            scores = scores_dict['scores']
            
            # total num of green false counts
            for score in scores:
                if score['green'] == True:
                    tally += 1
                if score['putts'] != None:
                    putts += score['putts']
                if score['strokes'] != None:
                    strokes += score['strokes'] 
                    
            # calculate avg putts
            avg_putts_per_round = putts // avg_putts_per_round
            
            # calculate avg strokes
            avg_strokes_per_round = strokes // avg_strokes_per_round
            
            # .collection().document() w/o .get() is to edit the document in database 
            update_score_ref = db.collection('scores').document(change.document.id)
            
            update_score_ref.set( {
                'green_successes':tally,
                'total_putts':putts,
                'total_strokes': strokes,
                'avg_putts':avg_putts_per_round,
                'avg_strokes':avg_strokes_per_round}, merge=True)
            
        elif change.type.name == 'REMOVED':
            print(f'Removed city: {change.document.id}')
            
    # include to indicate callback function completion
    callback_done.set()


# reference collection of scores
doc_ref = db.collection(u'scores')

# Watch/listen to the document | async? 
doc_watch = doc_ref.on_snapshot(on_snapshot)
    
# call an internal forever loop w/ delay
while True:
    time.sleep(1)
    










