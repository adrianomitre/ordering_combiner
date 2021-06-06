#!/usr/bin/env ruby

if ARGV.size < 1
  puts "usage #{__FILE__} <input_csv_file> [random_search_iterations]"
  exit
end
filename = ARGV[0]

require_relative 'ordering_extractor'
names_orderings_map = extract_orderings_from_csv(filename)

=begin
names_orderings_map has the following structure:
{
  :"Fulana"=>[:"Web Traffic Time Series Forecasting", :"Fake News Classification", :"Wikipedia Promotional Articles", :"BigQuery-Geotab Intersection Congestion", :"Painter by Numbers", :"A Century of Portraits", :"OpenMIC 2018", :"Retinal OCT Images", :"Microsoft Malware Prediction", :"Santander Customer Satisfaction"],
  :"Beltrana"=>[:"Santander Customer Satisfaction", :"Web Traffic Time Series Forecasting", :"Fake News Classification", :"Retinal OCT Images", :"A Century of Portraits", :"Painter by Numbers", :"Wikipedia Promotional Articles", :"Microsoft Malware Prediction", :"OpenMIC 2018", :"BigQuery-Geotab Intersection Congestion"],
  :"Sicrana"=>[:"Fake News Classification", :"Retinal OCT Images", :"Painter by Numbers", :"Santander Customer Satisfaction", :"Wikipedia Promotional Articles", :"Web Traffic Time Series Forecasting", :"Microsoft Malware Prediction", :"A Century of Portraits", :"BigQuery-Geotab Intersection Congestion", :"OpenMIC 2018"],
  :"Fulano"=>[:"Santander Customer Satisfaction", :"Fake News Classification", :"Web Traffic Time Series Forecasting", :"BigQuery-Geotab Intersection Congestion", :"Wikipedia Promotional Articles", :"Retinal OCT Images", :"Microsoft Malware Prediction", :"Painter by Numbers", :"A Century of Portraits", :"OpenMIC 2018"],
  :"Beltrano"=>[:"Santander Customer Satisfaction", :"Web Traffic Time Series Forecasting", :"Fake News Classification", :"Wikipedia Promotional Articles", :"Retinal OCT Images", :"A Century of Portraits", :"BigQuery-Geotab Intersection Congestion", :"Painter by Numbers", :"Microsoft Malware Prediction", :"OpenMIC 2018"]
}

Feel free to hard code your own input.
=end

require_relative 'solver'
random_search_iterations = ARGV[1].to_i
solution = Solver.solve(names_orderings_map, random_search_iterations=random_search_iterations)
Solver.report(solution)
