/* ************************************************************************** */
/*                                                                            */
/*                                                             _  __    __    */
/*   pacer-v2.c                                               /_\/ / /\ \ \   */
/*                                                           //_\\ \/  \/ /   */
/*   By: myrrysart | artwizard <hello@myrrys.art>           /  _  \  /\  /    */
/*                                                          \_/ \_/\/  \/     */
/*   Created: 2025/02/01 18:10:06 by myrrysart | artwizard                    */
/*   Updated: 2025/02/01 18:10:27 by myrrysart | artwizard     myrrys.art     */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>


void	write_number(int n)
{
	char	c;
	
	if (n >= 10)
	{
		write_number(n / 10);
		write_number(n % 10);
		return;
	}
	c = n + '0';
	write(1, &c, 1);
}

int	main(int argc, char **argv)
{
	int	block_count;
	int	minutes;
	int	total_minutes;
	char	*work_msg;
	char	*break_msg;
	char	*water_msg;
	char	*food_msg;
	char	*final_msg;

	if (argc != 2)
	{
		write(1, "Usage: 1 argument for number of minutes already worked.\n", 56);
		return (1);
	}
	block_count = 0;
	minutes = 0;
	total_minutes = atoi(argv[1]);
	work_msg = "\n---Coding block---\n";
	break_msg = "\n---Movement block---\n";
	water_msg = "\n---Drink water!---\n";
	food_msg = "\n---Food time!---\n";
	final_msg = "\nTotal minutes: ";

	while (total_minutes < (9 * 60))
	{
		write_number(block_count);
		write(1, work_msg, 20);

		minutes = 0;
		while (minutes < 57)
		{
			if (!(minutes % 15))
				write(1, water_msg, 20);
			sleep(60);
			minutes++;
			total_minutes++;
		}

		write(1, break_msg, 22);
		minutes = 0;
		while (minutes < 13)
		{
			sleep(60);
			minutes++;
			total_minutes++;
		}

		if (total_minutes >= (4 * 60) && total_minutes < ((4 * 60) + 30))
			write(1, food_msg, 18);

		block_count++;
		if (block_count > 9)
			block_count = 0;
	}
	write(1, "\nDay complete!\n", 15);
	write(1, final_msg, 16);
	write_number(total_minutes);
	write(1, "\n", 1);
	return (0);
}
