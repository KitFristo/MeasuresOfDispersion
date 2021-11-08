using Plots


# A function to calculate the mean of a distribution.
function average(distribution::Array)

    # Find the sum of all values in the distribution.
    total = sum(distribution)

    # Find the count of numbers in the distribution.
    count = length(distribution)

    # Calculate the mean by taking the sum of all values in the distribution
    # divided by the count of numbers in the distribution.
    average = total / count

end


# A function to calculate the standard deviation of a distribution.
function standard_deviation(values::Array)

    # Set an empty array to hold all the distances between values and the
    # mean of the distribution.
    total_distances = []

    # Calculate the mean of the values in the distribution.
    values_average = average(values)

    # Calculate the count of values in the distribution.
    count = length(values)

    # Enumerate over all values in the distribution and calculate the
    # distance between the value and the mean of the distribution squared.
    # Store that distance in an array.
    for value in values

        distance = (value - values_average)^2
        push!(total_distances, distance)

    end

    # Sum all the distances from the array into a single value.
    total_distance = sum(total_distances)

    # Calculate the standard deviation of the distribution by taking the sum
    # of the distances and divide it by the count of values in our
    # distribution.
    std_dev = sqrt(total_distance / count)

end


# A function to calculate the mean absolute deviation of a distribution.
function mean_absolute_deviation(values::Array)

    # Set an empty array to hold all the distances between values and the
    # average of the distribution.
    total_distances = []

    # Calculate the mean of the values in the distribution.
    values_average = average(values)

    # Calculate the count of values in the distribution.
    count = length(values)

    # Enumerate over all values in the distribution and calculate the
    # absolute value of the distance between the given value and the average
    # of the distribution. Store that distance in an array.
    for value in values

        distance = abs(value - values_average)
        push!(total_distances, distance)

    end

    # Sum all the distances from the array into a single value.
    total_distance = sum(total_distances)

    # Calculate the mean absolute deviation by taking the sum of the
    # distances and divide it by the count of values in our distribution.
    mean_abs_dev = total_distance / count

end


# A function to calculate the standard deviation and mean absolute deviation
# of a distribution with one dynamic value.
function calculate_sd_and_mad(values::Array, number::Int64)

    # Add the outlier we passed to our distribution.
    test_values = cat(values, number, dims=1)

    # call the functions to calculate standard deviation and mean absolute
    # deviation.
    std_dev = standard_deviation(test_values)
    mean_abs_dev = mean_absolute_deviation(test_values)

    return std_dev, mean_abs_dev

end


# A function to analyze the results of the data.
function analysis(numbers::Array, std_devs::Array, mean_abs_devs::Array,
    deltas::Array)

    # A plot of the standard deviation and mean absolute deviation against
    # the outlier values.
    versus_plot = Plots.plot(
        numbers,
        [std_devs, mean_abs_devs],
        title = (
            "Standard Deviation and Mean Absolute Deviation"
            ),
        label = ["Standard Deviation" "Mean Absolute Deviation"],
        xlabel = "Outlier Value"
        )

    # A plot of the difference between standard deviation and mean absolute
    # deviation against the outlier values.
    delta_plot = Plots.plot(
        numbers,
        deltas,
        title = (
            "Difference Between Standard Deviation and 
            Mean Absolute Deviation"
            ),
        xlabel = "Outlier Value",
        label = "Difference"
        )

    # Both plots next to each other and output a .png file of them.
    Plots.plot(versus_plot, delta_plot, layout = (2, 1))
    savefig("./plots/measures_of_dispersion.png")

end


# The main function for calculating statistical values and running the
# plotting and analysis functions.
function main()

    # Setup the base distribution.
    sample_one = [1, 2, 3, 4, 5]

    # Setup arrays to hold the outlier, standard deviation, mean absolute
    # deviation and the difference between the two from each iteration.
    numbers = []
    std_devs = []
    mean_abs_devs = []
    deltas = []

    # Enumerate over a range of values:
    for number in 1:100000

        # Calculate and return the standard deviation and mean absolute
        # deviation for our distribution.
        std_dev, mean_abs_dev = calculate_sd_and_mad(sample_one, number)

        # Calculate the difference between the standard deviation and mean
        # absolute deviation.
        delta = std_dev - mean_abs_dev

        # Add the values we collected to their respective arrays to conduct
        # analysis later on.
        push!(numbers, number)
        push!(std_devs, std_dev)
        push!(mean_abs_devs, mean_abs_dev)
        push!(deltas, delta)

    end

    # Conduct an analysis of our data.
    analysis(numbers, std_devs, mean_abs_devs, deltas)

end


# Execute our main function.
main()
