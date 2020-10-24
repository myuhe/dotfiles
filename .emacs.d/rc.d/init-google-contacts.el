;; Example of using google-contacts.el
;; Load library
(require 'google-contacts)

;; Configure username/password to GMail
(setq google-contacts-email "yuhei.maeda@gmail.com")
(setq google-contacts-passwd "sheephead")

;; Retrieve Google contacts and put the resulting list in `my-contacts' variable:
(defvar my-contacts (google-contacts-retrieve))

;; Use contents of `my-contacts' variable to whatever you need it for.
;; It's structure should be easy to understand.
;; You can look at it by doing a "C-h v my-contacts" to describe the variable.

;; You can merge the contacts into BBDB address book:
;;(google-contacts-merge-with-bbdb my-contacts)

;; Here's an interactive function that retrieves Google contacts and updates
;; BBDB:
(defun google-contacts-update-bbdb()
  "Fetch contacts from Google and merge them into local BBDB."
  (interactive)
  (google-contacts-merge-with-bbdb (google-contacts-retrieve)))
;; Please read warning about function `google-contacts-merge-with-bbdb' in top
;; of google-contacts.el file.
