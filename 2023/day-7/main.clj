(ns main
  (:require [clojure.string :as strings]))

; Read file and split strings as needed.
(defn read-file []
  (->> (slurp "input.txt") strings/split-lines (map #(strings/split % #" "))))

; Hands and cards types for comparison.
(def hands-types {:five-of-a-kind 7 :four-of-a-kind 6 :full-house 5 :three-of-a-kind 4 :two-pair 3 :pair 2 :high-card 1})
(def cards-types {\A 13 \K 12 \Q 11 \J 10 \T 9 \9 8 \8 7 \7 6 \6 5 \5 4 \4 3 \3 2 \2 1})
(def cards-with-jokers (assoc cards-types \J 0))

; Get the type of the hand.
(defn get-type [hand]
  (let [counts (-> hand frequencies vals sort)]
    (cond
      (= counts '(5)) :five-of-a-kind
      (= counts '(1, 4)) :four-of-a-kind
      (= counts '(2, 3)) :full-house
      (= counts '(1, 1, 3)) :three-of-a-kind
      (= counts '(1, 2, 2)) :two-pair
      (= counts '(1, 1, 1, 2)) :pair
      :else :high-card)))

; Get the type of the hand but now with the joker card.
(defn get-type-with-joker [hand]
  (if (every? #(= \J %) hand) :five-of-a-kind ; The case where every card is a joker, then surely is a five-of-a-kind.
      (let [filtered-hand (filter #(not= \J %) hand)
            counts (frequencies filtered-hand)
            non-joker-count (->> counts vals (reduce +))
            joker-count (- 5 non-joker-count)
            best-card (->> counts (apply max-key val) key str)
            hand-with-jokers (apply str (concat filtered-hand (repeat joker-count best-card)))]
        (get-type (if (zero? joker-count) hand hand-with-jokers)))))

; Compare just the value of cards in order.
(defn compare-cards [left right m]
  (let [pairs (partition 2 (interleave (map m left) (map m right)))
        first-card (->> pairs (map #(compare (nth % 0) (nth % 1))) (drop-while zero?) first)]
    (if (nil? first-card) 0 first-card)))

; Compare the hand type. f is the function to get the type of the hand (could be with joker or not).
; m is the function to get the value of the card. Jokers are always 0.
(defn compare-hands [left right f m]
  (if (= (f left) (f right))
    (compare-cards left right m)
    (compare (hands-types (f left)) (hands-types (f right)))))

; Function to sort sort the data by a function. Then maps with product of index and bet.
; Then sum all the values and print the result.
(defn consume-data [data get-func cards-map]
  (->> data
       (sort-by first #(compare-hands %1 %2 get-func cards-map))
       (map second) (map #(Integer/parseInt %))
       (map-indexed #(* (inc %1) %2)) (reduce +) println))

(defn solve-part-one [data]
  (consume-data data get-type cards-types))

(defn solve-part-two [data]
  (consume-data data get-type-with-joker cards-with-jokers))

(doto (read-file)
  solve-part-one
  solve-part-two)
